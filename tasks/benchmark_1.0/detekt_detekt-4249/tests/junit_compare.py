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
HASH_SUFFIX_RE = re.compile(r"@[0-9a-fA-F]+$")
STATUS_PRIORITY: Dict[str, int] = {"FAIL": 3, "SKIP": 2, "PASS": 1}


def _is_parameterized(name: str | None) -> bool:
    return bool(name and PARAM_RE.search(name))


def _strip_hash(part: str | None) -> str:
    return HASH_SUFFIX_RE.sub("", (part or "").strip())


def _make_test_id(classname: str | None, name: str | None) -> str:
    cls = _strip_hash(classname)
    method = _strip_hash(name) or "<unnamed>"
    return f"{cls}.{method}" if cls else method


def _load_xml(text: str) -> ET.Element:
    try:
        return ET.fromstring(text)
    except ET.ParseError:
        cleaned = re.sub(r"<!--.*?-->", "", text, flags=re.DOTALL)
        return ET.fromstring(cleaned)


def parse_junit_xml(xml_text: str, drop_parameterized: bool = False) -> Dict[str, str]:
    root = _load_xml(xml_text.lstrip("\ufeff").strip())
    results: Dict[str, str] = {}
    for case in root.iter("testcase"):
        classname = case.get("classname")
        name = case.get("name")
        if drop_parameterized and (_is_parameterized(name) or _is_parameterized(classname)):
            continue
        test_id = _make_test_id(classname, name)
        if case.find("skipped") is not None:
            status = "SKIP"
        elif case.find("failure") is not None or case.find("error") is not None:
            status = "FAIL"
        else:
            status = "PASS"
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
    f2p_tests = expected.get("f2p_tests", [])
    p2p_tests = expected.get("p2p_tests", [])
    s2p_tests = expected.get("s2p_tests", [])
    n2p_tests = expected.get("n2p_tests", [])

    if not f2p_tests and not p2p_tests and not s2p_tests and not n2p_tests:
        print("WARNING: no expected tests defined; defaulting reward to 0", file=sys.stderr)
        reward_path.write_text("0\n")
        sys.exit(0)

    # Load test-patch results from expected_tests.json
    tp_result = expected.get("test_patch_result", {})
    tp_passed = set(tp_result.get("passed_tests", []))
    tp_failed = set(tp_result.get("failed_tests", []))
    tp_skipped = set(tp_result.get("skipped_tests", []))

    # Parse JUnit XML (fix-patch results)
    xml_path = Path(args.xml)
    if not xml_path.exists():
        print(f"ERROR: XML file not found: {xml_path}", file=sys.stderr)
        reward_path.write_text("0\n")
        sys.exit(0)

    try:
        fix_results = parse_junit_xml(
            xml_path.read_text(encoding="utf-8", errors="replace"),
            drop_parameterized=True,
        )
    except Exception as exc:
        print(f"ERROR: failed to parse JUnit XML: {exc}", file=sys.stderr)
        reward_path.write_text("0\n")
        sys.exit(0)

    # Load run results (base commit, before test patch) for anomalous pattern check
    run_result = expected.get("run_result", {})
    run_passed = set(run_result.get("passed_tests", []))
    run_failed = set(run_result.get("failed_tests", []))
    run_skipped = set(run_result.get("skipped_tests", []))

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
