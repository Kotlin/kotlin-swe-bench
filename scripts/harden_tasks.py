#!/usr/bin/env python3
"""Harden the Kotlin SWE-bench tasks in place.

This deterministic transform rewrites, for every task under ``tasks/``:

1. ``tests/test.sh``      -> fail-closed verifier (no exit-code fallback, default
                             reward 0, hidden-patch enforced, stale JUnit XML removed).
2. ``task.toml``          -> corpus allowlist network policy (drops ``allow_internet``).
3. ``environment/``       -> adds ``seal_git_history.sh`` and wires it into the
                             ``Dockerfile`` after the prepare/tooling steps.

It touches only those four files per task and refuses to modify anything it does
not recognise. Every step is idempotent, so the script can be re-run safely.

Usage::

    scripts/harden_tasks.py                 # apply every phase to all tasks
    scripts/harden_tasks.py --phase test    # only rewrite tests/test.sh
    scripts/harden_tasks.py --phase toml    # only rewrite task.toml
    scripts/harden_tasks.py --phase seal    # only add/wire seal_git_history.sh
    scripts/harden_tasks.py --check         # verify the hardening (no writes)
"""
from __future__ import annotations

import argparse
import hashlib
import re
import subprocess
import sys
from pathlib import Path


# The nine verifier byte-shapes shipped in this repo (all 106 tasks reduce to
# these). Refusing anything else keeps the transform from silently rewriting a
# harness it was not designed for.
KNOWN_VERIFIERS = {
    "0adaac4198cf95f64a7fa6ffa051bb70f40153dd51696f3392bf347d9f5cdd27",
    "da0048a0713cd4e1d9eb111b3ecd014eee3fcda87d0002829bb5c34c39d46564",
    "a1ca78e6a73d5e9e22dfb9a2a1246ea8868b7ee1ff72ee552892fa3b353fa90e",
    "ce44cbf44deb81d377fde799d78972d2983575217bbea40bddae1165518a6fb8",
    "cc8553e4a2ed3459a17ce780dfbf23968117928df952d13196f58075543f2274",
    "750d235e476b0d9b78d7e1135a370a178dd489e2051d8dbcc50630e1754153aa",
    "ded2c78fb75c65f6c44407b63d3d27ee1f07da7d4c6767fcec9b8faa757244bc",
    "0831d3ef5640a53a4483f456fd003b28488eec7e4a8168d379c43004896d2fe4",
    "aaac9b53a55c89ec8e7bed6225d3a2a935e8bc473b663f606c194e54b2de1d8d",
}

# Allowlist mirrored from the reference corpus (swe-tasks-corpus kotlin-bench):
# the superset that lets builds resolve Maven/Gradle/doc dependencies while the
# open web and GitHub code/raw hosts stay unreachable.
ALLOWED_HOSTS = [
    "repo.maven.apache.org", "repo1.maven.org", "plugins.gradle.org",
    "services.gradle.org", "maven.google.com", "maven.pkg.jetbrains.space",
    "maven.reposilite.com", "oss.sonatype.org", "pub.dartlang.org", "pub.dev",
    "kotlinlang.org", "*.kotlinlang.org", "docs.gradle.org", "docs.gradle.com",
    "gradle.com", "scans.gradle.com", "developer.android.com", "*.jetbrains.com",
    "ankidroid.org", "docs.ankidroid.org", "detekt.dev", "www.jooq.org",
    "docs.oasis-open.org", "pnpm.js.org", "www.overleaf.com", "texdoc.org",
    "mirrors.mit.edu", "mirrors.ibiblio.org", "ctan.math.utah.edu",
    "youtrack.jetbrains.com", "issuetracker.google.com", "nvd.nist.gov",
    "tex.meta.stackexchange.com", "kotlinlang.slack.com", "docs.google.com",
    "drive.google.com", "youtu.be", "hannah-sten.github.io", "kotlin.github.io",
    "pinterest.github.io", "docs.github.com", "ant.apache.org",
    "oss-review-toolkit.org", "www.postgresql.org", "android.googlesource.com",
    "android-review.googlesource.com",
]
ALLOWED_HOSTS_TOML = "[" + ", ".join('"%s"' % h for h in ALLOWED_HOSTS) + "]"


SEAL_GIT_HISTORY = """#!/bin/bash
set -euo pipefail

# Seal the task checkout so only the pinned base commit (and its ancestors)
# remain reachable. Every later commit -- notably the published upstream fix --
# becomes unreferenced and is pruned, and no remote is left to re-fetch it.
cd "$1"

base_sha="$(git rev-parse HEAD)"

# Point a single branch at the base commit -- the only ref left standing --
# discarding every other local branch/tag/remote-tracking ref that could reach
# a future commit.
git checkout -B task-base "$base_sha"
git for-each-ref --format='%(refname)' refs/heads refs/tags refs/remotes | while read -r ref; do
  [ "$ref" = "refs/heads/task-base" ] && continue
  git update-ref -d "$ref"
done

# Remove remotes so the future commits can't be re-fetched from origin.
git remote | while read -r name; do
  git remote remove "$name"
done

# Drop reflog entries -- they can otherwise resurrect a commit that was
# checked out before the seal ran.
git reflog expire --expire=now --expire-unreachable=now --all

# Garbage-collect immediately: unreachable objects (future commits and anything
# only reachable from them) are deleted now, not after git's default grace period.
git gc --prune=now

# Post-conditions: fail the build loudly if the seal did not hold.
[ "$(git rev-parse HEAD)" = "$base_sha" ] || { echo "seal: HEAD moved" >&2; exit 1; }
[ -z "$(git remote)" ] || { echo "seal: a remote survived" >&2; exit 1; }
[ -z "$(git for-each-ref --format='%(refname)' refs/remotes refs/tags)" ] || {
  echo "seal: a remote-tracking or tag ref survived" >&2; exit 1; }
[ "$(git for-each-ref --format='%(refname)' refs/heads)" = "refs/heads/task-base" ] || {
  echo "seal: an unexpected local branch survived" >&2; exit 1; }
"""

DOCKERFILE_SEAL_BLOCK = (
    "# Seal Git history after the prepare/warm and tooling steps above so only\n"
    "# the pinned base commit remains reachable (blocks fetching the upstream fix).\n"
    "COPY seal_git_history.sh /tmp/seal_git_history.sh\n"
    "RUN bash /tmp/seal_git_history.sh {workdir}\n"
)


def sha256(text: str) -> str:
    return hashlib.sha256(text.encode()).hexdigest()


def is_test_sh_hardened(text: str) -> bool:
    return (
        text.startswith("#!/bin/bash\nset -euo pipefail")
        and "echo 0 > /logs/verifier/reward.txt" in text
        and "Fallback" not in text
        and "exit_code" not in text
    )


def harden_test_sh(text: str) -> str:
    """Rewrite one verifier to the fail-closed shape. Idempotent."""
    if is_test_sh_hardened(text):
        return text
    if sha256(text) not in KNOWN_VERIFIERS:
        raise ValueError("Unrecognized verifier bytes: refusing to patch it")

    # 1. Strict mode: abort on any unhandled error or unset variable.
    text, n = re.subn(r"(?m)^set -uo pipefail$", "set -euo pipefail", text)
    if n != 1:
        raise ValueError("Expected exactly one 'set -uo pipefail' line")

    # 2. Fail-closed default: wipe logs and write reward 0 before any work.
    text, n = re.subn(
        r"(?m)^mkdir -p /logs/verifier$",
        "rm -rf /logs/verifier && mkdir -p /logs/verifier\n"
        "echo 0 > /logs/verifier/reward.txt",
        text,
    )
    if n != 1:
        raise ValueError("Expected exactly one '/logs/verifier' bootstrap line")

    # 3. Enforce the hidden test patch: a run that cannot apply it scores 0.
    text, n = re.subn(
        r"(?m)^git apply --whitespace=nowarn /tests/test\.patch$",
        "if ! git apply --whitespace=nowarn /tests/test.patch; then\n"
        '  echo "ERROR: hidden test patch did not apply; reward remains 0." >&2\n'
        "  exit 1\n"
        "fi",
        text,
    )
    if n != 1:
        raise ValueError("Expected exactly one hidden test-patch application")

    # 4. Remove stale JUnit XML right before Gradle so only this run can score;
    #    also drop the now-unused exit-code capture.
    def _gradle(match: re.Match) -> str:
        return (
            "# Remove stale JUnit reports so only this run's results can score.\n"
            "find . -type f -path '*/build/test-results/*/TEST*.xml' -delete\n"
            + match.group(1)
            + "\n"
        )

    text, n = re.subn(
        r"(?m)^(.*gradlew.* \|\| true)$\n(?:exit_code=\$\?\n)?",
        _gradle,
        text,
    )
    if n != 1:
        raise ValueError("Expected exactly one Gradle invocation")

    # 5. Drop the exit-code fallback entirely: reward stays 0 unless the scorer
    #    validates fresh reports against expected_tests.json.
    anchor = text.index("if bash /tests/kotlin_logs_collector.sh")
    branch = text.index("\nelse\n", anchor)
    text = text[:branch] + "\nfi\n"

    if not is_test_sh_hardened(text):
        raise ValueError("Hardened verifier failed its own shape check")
    return text


def harden_task_toml(text: str) -> str:
    """Replace the network policy with the corpus allowlist model. Idempotent."""
    if "allow_internet" not in text:
        return text

    text, n = re.subn(
        r'(?m)^allow_internet = (?:true|false)$',
        'network_mode = "public"',
        text,
    )
    if n != 1:
        raise ValueError("Expected exactly one 'allow_internet' policy")

    text, n = re.subn(
        r'(?m)^(\[verifier\]\nimplemented = false\ntimeout_sec = 900\.0)$',
        r'\1\nnetwork_mode = "public"',
        text,
    )
    if n != 1:
        raise ValueError("Unrecognized [verifier] section")

    text, n = re.subn(
        r'(?m)^(\[agent\]\ntimeout_sec = 1800\.0)$',
        r'\1\nnetwork_mode = "allowlist"\nallowed_hosts = ' + ALLOWED_HOSTS_TOML,
        text,
    )
    if n != 1:
        raise ValueError("Unrecognized [agent] section")
    return text


def workdir_of(task: Path) -> str:
    dockerfile = (task / "environment/Dockerfile").read_text()
    workdirs = re.findall(r"(?m)^WORKDIR (/home/\S+)$", dockerfile)
    if len(workdirs) != 1:
        raise ValueError(f"Expected exactly one WORKDIR in {task.name}")
    return workdirs[0]


def harden_dockerfile(text: str, workdir: str) -> str:
    """Wire seal_git_history.sh in before the final WORKDIR. Idempotent."""
    if "seal_git_history.sh" in text:
        return text
    block = DOCKERFILE_SEAL_BLOCK.format(workdir=workdir)
    replaced, n = re.subn(
        r"(?m)^(WORKDIR /home/\S+)$",
        block + r"\1",
        text,
    )
    if n != 1:
        raise ValueError("Expected exactly one WORKDIR to anchor the seal step")
    return replaced


def process_task(task: Path, phases: set[str]) -> list[str]:
    changed: list[str] = []

    if "test" in phases:
        path = task / "tests/test.sh"
        before = path.read_text()
        after = harden_test_sh(before)
        if after != before:
            path.write_text(after)
            changed.append("tests/test.sh")

    if "toml" in phases:
        path = task / "task.toml"
        before = path.read_text()
        after = harden_task_toml(before)
        if after != before:
            path.write_text(after)
            changed.append("task.toml")

    if "seal" in phases:
        workdir = workdir_of(task)
        seal = task / "environment/seal_git_history.sh"
        if not seal.exists() or seal.read_text() != SEAL_GIT_HISTORY:
            seal.write_text(SEAL_GIT_HISTORY)
            seal.chmod(0o755)
            changed.append("environment/seal_git_history.sh")
        dockerfile = task / "environment/Dockerfile"
        before = dockerfile.read_text()
        after = harden_dockerfile(before, workdir)
        if after != before:
            dockerfile.write_text(after)
            changed.append("environment/Dockerfile")

    return changed


def check_task(task: Path) -> list[str]:
    problems: list[str] = []

    test_sh = (task / "tests/test.sh").read_text()
    if not is_test_sh_hardened(test_sh):
        problems.append("tests/test.sh is not fail-closed")
    for needle in (
        "if ! git apply --whitespace=nowarn /tests/test.patch; then",
        "find . -type f -path '*/build/test-results/*/TEST*.xml' -delete",
    ):
        if needle not in test_sh:
            problems.append(f"tests/test.sh missing guard: {needle}")
    syntax = subprocess.run(["bash", "-n"], input=test_sh, text=True, capture_output=True)
    if syntax.returncode != 0:
        problems.append("tests/test.sh fails 'bash -n': " + syntax.stderr.strip())

    toml = (task / "task.toml").read_text()
    if "allow_internet" in toml:
        problems.append("task.toml still declares allow_internet")
    if 'network_mode = "allowlist"' not in toml or "allowed_hosts = " not in toml:
        problems.append("task.toml missing agent allowlist policy")
    if toml.count('network_mode = "public"') != 2:
        problems.append("task.toml missing verifier/environment public policy")

    seal = task / "environment/seal_git_history.sh"
    if not seal.exists() or seal.read_text() != SEAL_GIT_HISTORY:
        problems.append("environment/seal_git_history.sh missing or unexpected")
    dockerfile = (task / "environment/Dockerfile").read_text()
    if "RUN bash /tmp/seal_git_history.sh " not in dockerfile:
        problems.append("environment/Dockerfile does not run the git seal")

    return problems


def iter_tasks(root: Path):
    return sorted(p for p in (root / "tasks").iterdir() if p.is_dir())


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--phase", choices=["all", "test", "toml", "seal"], default="all")
    parser.add_argument("--check", action="store_true", help="verify only; make no changes")
    args = parser.parse_args()

    tasks = iter_tasks(args.root)
    if not tasks:
        print("No tasks found under", args.root / "tasks", file=sys.stderr)
        return 1

    if args.check:
        failures = 0
        for task in tasks:
            problems = check_task(task)
            if problems:
                failures += 1
                print(f"FAIL {task.name}")
                for problem in problems:
                    print("   -", problem)
        if failures:
            print(f"\n{failures}/{len(tasks)} tasks failed the hardening check")
            return 1
        print(f"OK: all {len(tasks)} tasks pass the hardening check")
        return 0

    phases = {"test", "toml", "seal"} if args.phase == "all" else {args.phase}
    touched = 0
    for task in tasks:
        changed = process_task(task, phases)
        if changed:
            touched += 1
            print(f"{task.name}: " + ", ".join(changed))
    print(f"\nPhase '{args.phase}': updated {touched}/{len(tasks)} tasks")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
