#!/usr/bin/env python3
"""
Parse JUnit XML produced by the test run and compare it against the
expected test list from the original bench (expected_tests.json).

This replicates the verification logic from run_evaluation.py:
  1. Parse the fix-patch test results (JUnit XML).
  2. Reconstruct per-test status transitions using pre-computed
     test_patch_result from the dataset.
  3. Validate the report (non-zero results, no new failures,
     fixed something, no anomalous patterns).
  4. Check that every expected f2p/p2p/s2p/n2p test lands in the
     correct transition category.

Different repos/toolchains in this dataset report test identifiers in
different textual shapes (Gradle "Class > method", JUnit4
Description.toString() "method (Class)", plain "Class.method",
space-joined "Class method", or bare class name for suite-level
results). Rather than assuming one shape, this builds every plausible
spelling from the real (classname, name) pair reported in the JUnit XML
and matches against whichever spelling the dataset actually used.

Usage:
    python3 /tests/junit_compare.py --xml <merged.xml> \
                                    --expected /tests/expected_tests.json \
                                    --reward /logs/verifier/reward.txt
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import Dict, Optional, Set, Tuple

# ---------------------------------------------------------------------------
# JUnit XML parsing  (mirrors multi_swe_bench/harness/repos/kotlin/junit_parser.py)
# ---------------------------------------------------------------------------

PARAM_RE = re.compile(r"\[.+?\]")
# JVM identity hashcodes (default Object.toString() output, e.g. "Foo@257d2393")
# embedded in a parameterized test's display name change on every run, so a
# dataset-recorded expected id can never match a fresh run's actual id byte
# for byte. Strip them wherever they appear, not just at the very end of the
# string, since ids are often compound (e.g. "name (classname)" or
# "name(...session=Foo@257d2393, other=...)") with the hash in the middle
# followed by arbitrary punctuation rather than end-of-string. A hash is a
# complete run of hex digits not immediately followed by another alnum char
# (which would mean it's not actually a standalone hash token).
EMBEDDED_HASH_RE = re.compile(r"@[0-9a-fA-F]{6,10}(?![0-9a-zA-Z])")
STATUS_PRIORITY: Dict[str, int] = {"FAIL": 3, "SKIP": 2, "PASS": 1}


def _strip_hash(part: str | None) -> str:
    return EMBEDDED_HASH_RE.sub("", (part or "").strip())


def _strip_hash_keep_ws(part: str | None) -> str:
    # Some datasets built their "name (classname)" id by concatenating the
    # *raw* (unstripped) JUnit name, so a name with incidental trailing
    # whitespace produces a double space before "(classname)" in the
    # recorded expected id. _strip_hash's .strip() would collapse that back
    # to a single space and the id would never match. Keep an
    # whitespace-preserving variant around for that shape specifically.
    return EMBEDDED_HASH_RE.sub("", part or "")


def _strip_embedded_hash(s: str) -> str:
    # Actual-side candidates are built from .strip()'d classname/name parts
    # (see _strip_hash), so an expected id with incidental leading/trailing
    # whitespace would otherwise never match even when everything else lines up.
    return EMBEDDED_HASH_RE.sub("", s).strip()


def _normalize_id_set(ids) -> Set[str]:
    return {_strip_embedded_hash(i) for i in ids}


def _strip_brackets(s: str) -> str:
    return PARAM_RE.sub("", s).strip()


def _test_id_candidates(classname: str | None, name: str | None) -> Set[str]:
    """Every plausible textual spelling of a test's identifier."""
    cls = _strip_hash(classname)
    method = _strip_hash(name) or "<unnamed>"
    raw_method = _strip_hash_keep_ws(name) or "<unnamed>"

    cls_variants = {cls, _strip_brackets(cls)}
    # Kotlin multiplatform reports sometimes mirror the method's target
    # suffix (e.g. "[jvm]") onto the class portion too.
    for token in PARAM_RE.findall(method):
        cls_variants.add(f"{cls}{token}")

    method_variants = {method, _strip_brackets(method), raw_method}

    candidates: Set[str] = set()
    for m in method_variants:
        if not m:
            m = "<unnamed>"
        candidates.add(m)
        for c in cls_variants:
            if not c:
                continue
            candidates.add(c)
            candidates.add(f"{c} > {m}")
            candidates.add(f"{c}.{m}")
            candidates.add(f"{c} {m}")
            candidates.add(f"{m} ({c})")
            candidates.add(f"{m}({c})")
            if not m.endswith(")"):
                candidates.add(f"{c}.{m}()")
                candidates.add(f"{c} > {m}()")
                candidates.add(f"{m}() ({c})")
    candidates.discard("")
    return candidates


def _load_xml(text: str) -> ET.Element:
    try:
        return ET.fromstring(text)
    except ET.ParseError:
        cleaned = re.sub(r"<!--.*?-->", "", text, flags=re.DOTALL)
        return ET.fromstring(cleaned)


def parse_junit_xml(xml_text: str) -> Dict[str, str]:
    root = _load_xml(xml_text.lstrip("﻿").strip())
    results: Dict[str, str] = {}
    for case in root.iter("testcase"):
        classname = case.get("classname")
        name = case.get("name")
        if case.find("skipped") is not None:
            status = "SKIP"
        elif case.find("failure") is not None or case.find("error") is not None:
            status = "FAIL"
        else:
            status = "PASS"
        for test_id in _test_id_candidates(classname, name):
            prev = results.get(test_id)
            if prev is None or STATUS_PRIORITY[status] > STATUS_PRIORITY[prev]:
                results[test_id] = status
    return results


# ---------------------------------------------------------------------------
# Report validation  (mirrors multi_swe_bench/harness/report.py  Report.check)
# ---------------------------------------------------------------------------

# Status constants matching TestStatus in the original codebase
NONE = "NONE"
PASS = "PASS"
FAIL = "FAIL"
SKIP = "SKIP"


def _get_test_patch_status(
    test_id: str,
    tp_passed: Set[str],
    tp_failed: Set[str],
    tp_skipped: Set[str],
) -> str:
    """Return the test_patch status for *test_id* (before the fix was applied)."""
    if test_id in tp_passed:
        return PASS
    if test_id in tp_failed:
        return FAIL
    if test_id in tp_skipped:
        return SKIP
    return NONE


def _get_run_status(
    test_id: str,
    run_passed: Set[str],
    run_failed: Set[str],
    run_skipped: Set[str],
) -> str:
    """Return the run status for *test_id* (before test patch was applied)."""
    if test_id in run_passed:
        return PASS
    if test_id in run_failed:
        return FAIL
    if test_id in run_skipped:
        return SKIP
    return NONE


def validate_and_classify(
    fix_results: Dict[str, str],
    tp_passed: Set[str],
    tp_failed: Set[str],
    tp_skipped: Set[str],
    run_passed: Optional[Set[str]] = None,
    run_failed: Optional[Set[str]] = None,
    run_skipped: Optional[Set[str]] = None,
) -> Tuple[bool, str, Dict[str, str], Dict[str, str], Dict[str, str], Dict[str, str]]:
    """
    Replicate Report.__post_init__ + Report.check from the original codebase.

    Returns (valid, error_msg, f2p_tests, p2p_tests, s2p_tests, n2p_tests).
    The category dicts map test_id -> fix_status for tests that ended up in
    each transition bucket.
    """
    run_passed = run_passed or set()
    run_failed = run_failed or set()
    run_skipped = run_skipped or set()

    # Collect all test names seen in either result set
    all_tests = set(fix_results.keys()) | tp_passed | tp_failed | tp_skipped

    # Build per-test (test_patch_status, fix_status) pairs
    tests: Dict[str, Tuple[str, str]] = {}
    for tid in all_tests:
        test_status = _get_test_patch_status(tid, tp_passed, tp_failed, tp_skipped)
        fix_status = fix_results.get(tid, NONE)
        tests[tid] = (test_status, fix_status)

    # --- Check 1: non-zero fix results ---
    if len(fix_results) == 0:
        return (False, "No test results captured after applying the fix patch.",
                {}, {}, {}, {})

    # --- Check 2: no new failures ---
    for tid, (test_st, fix_st) in tests.items():
        if test_st == PASS and fix_st == FAIL:
            return (False,
                    f"Test passed before fix but failed after: {tid}",
                    {}, {}, {}, {})

    # --- Check 3: fixed something ---
    fixed_something = False
    for tid, (test_st, fix_st) in tests.items():
        if test_st != PASS and fix_st == PASS:
            fixed_something = True
            break

    if not fixed_something:
        return (False, "No test transitioned from non-pass to pass.",
                {}, {}, {}, {})

    # --- Check 4: anomalous pattern ---
    # Mirrors report.py Report.check: test was NONE/SKIP, fix is FAIL, but run was PASS.
    for tid, (test_st, fix_st) in tests.items():
        run_st = _get_run_status(tid, run_passed, run_failed, run_skipped)
        if (
            (test_st == NONE or test_st == SKIP)
            and fix_st == FAIL
            and run_st == PASS
        ):
            return (False,
                    f"Anomalous pattern detected for {tid}: "
                    f"run={run_st}, test_patch={test_st}, fix={fix_st}",
                    {}, {}, {}, {})

    # --- Classify tests into categories ---
    f2p: Dict[str, str] = {}
    p2p: Dict[str, str] = {}
    s2p: Dict[str, str] = {}
    n2p: Dict[str, str] = {}

    for tid, (test_st, fix_st) in tests.items():
        if test_st == PASS and fix_st == PASS:
            p2p[tid] = fix_st
        elif test_st == FAIL and fix_st == PASS:
            f2p[tid] = fix_st
        elif test_st == SKIP and fix_st == PASS:
            s2p[tid] = fix_st
        elif test_st == NONE and fix_st == PASS:
            n2p[tid] = fix_st

    return (True, "", f2p, p2p, s2p, n2p)


# ---------------------------------------------------------------------------
# Main comparison logic  (mirrors gen_report.py  gen_eval_reports)
# ---------------------------------------------------------------------------

def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--xml",      required=True, help="Path to merged JUnit XML file")
    ap.add_argument("--expected", required=True, help="Path to expected_tests.json")
    ap.add_argument("--reward",   required=True, help="Path to reward.txt to write")
    args = ap.parse_args()

    reward_path = Path(args.reward)
    reward_path.parent.mkdir(parents=True, exist_ok=True)

    # Load expected tests
    expected = json.loads(Path(args.expected).read_text(encoding="utf-8"))
    f2p_tests = [_strip_embedded_hash(t) for t in expected.get("f2p_tests", [])]
    p2p_tests = [_strip_embedded_hash(t) for t in expected.get("p2p_tests", [])]
    s2p_tests = [_strip_embedded_hash(t) for t in expected.get("s2p_tests", [])]
    n2p_tests = [_strip_embedded_hash(t) for t in expected.get("n2p_tests", [])]

    if not f2p_tests and not p2p_tests and not s2p_tests and not n2p_tests:
        print("WARNING: no expected tests defined; defaulting reward to 0", file=sys.stderr)
        reward_path.write_text("0\n")
        sys.exit(0)

    # Load test-patch results from expected_tests.json
    tp_result = expected.get("test_patch_result", {})
    tp_passed = _normalize_id_set(tp_result.get("passed_tests", []))
    tp_failed = _normalize_id_set(tp_result.get("failed_tests", []))
    tp_skipped = _normalize_id_set(tp_result.get("skipped_tests", []))

    # Parse JUnit XML (fix-patch results)
    xml_path = Path(args.xml)
    if not xml_path.exists():
        print(f"ERROR: XML file not found: {xml_path}", file=sys.stderr)
        reward_path.write_text("0\n")
        sys.exit(0)

    try:
        fix_results = parse_junit_xml(
            xml_path.read_text(encoding="utf-8", errors="replace"),
        )
    except Exception as exc:
        print(f"ERROR: failed to parse JUnit XML: {exc}", file=sys.stderr)
        reward_path.write_text("0\n")
        sys.exit(0)

    # Load run results (base commit, before test patch) for anomalous pattern check
    run_result = expected.get("run_result", {})
    run_passed = _normalize_id_set(run_result.get("passed_tests", []))
    run_failed = _normalize_id_set(run_result.get("failed_tests", []))
    run_skipped = _normalize_id_set(run_result.get("skipped_tests", []))

    # Validate and classify (mirrors report.py Report.check)
    valid, error_msg, f2p_map, p2p_map, s2p_map, n2p_map = validate_and_classify(
        fix_results, tp_passed, tp_failed, tp_skipped,
        run_passed, run_failed, run_skipped,
    )

    if not valid:
        print(f"INVALID report: {error_msg}", file=sys.stderr)
        reward_path.write_text("0\n")
        sys.exit(0)

    # Check category membership (mirrors gen_report.py gen_eval_reports)
    failures = []
    for tid in f2p_tests:
        if tid not in f2p_map:
            status = fix_results.get(tid, "MISSING")
            failures.append(f"f2p NOT in f2p_map [{status}]: {tid}")

    for tid in p2p_tests:
        if tid not in p2p_map:
            status = fix_results.get(tid, "MISSING")
            failures.append(f"p2p NOT in p2p_map [{status}]: {tid}")

    for tid in s2p_tests:
        if tid not in s2p_map:
            status = fix_results.get(tid, "MISSING")
            failures.append(f"s2p NOT in s2p_map [{status}]: {tid}")

    for tid in n2p_tests:
        if tid not in n2p_map:
            status = fix_results.get(tid, "MISSING")
            failures.append(f"n2p NOT in n2p_map [{status}]: {tid}")

    if failures:
        print("Verification failed:", file=sys.stderr)
        for msg in failures:
            print(f"  {msg}", file=sys.stderr)
        reward_path.write_text("0\n")
    else:
        print(
            f"All {len(f2p_tests)} f2p, {len(p2p_tests)} p2p, "
            f"{len(s2p_tests)} s2p and {len(n2p_tests)} n2p tests verified.",
            file=sys.stderr,
        )
        reward_path.write_text("1\n")


if __name__ == "__main__":
    main()
