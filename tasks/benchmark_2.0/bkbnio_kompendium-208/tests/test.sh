#!/bin/bash
set -euo pipefail

mkdir -p /logs/verifier
rm -f \
  /logs/verifier/reward.txt \
  /logs/verifier/reward.json \
  /logs/verifier/all-testsuites.xml
echo 0 > /logs/verifier/reward.txt

if ! command -v python3 >/dev/null 2>&1; then
  if ! apt-get update -qq ||
    ! DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3; then
    echo "ERROR: failed to install Python." >&2
    exit 0
  fi
  rm -rf /var/lib/apt/lists/*
fi

cd /kompendium

# Separate verifier: this container starts from the task image, not from the agent's.
# Rebuild the agent's tree from the patch the collect hook in task.toml captured: back
# to the base commit (the image's own uncommitted setup edits are part of the patch),
# then apply it. Test reports come only from this run, so any the image or the patch
# brought are dropped.
AGENT_CHANGES=/logs/artifacts/agent_changes.patch
if [[ ! -f "$AGENT_CHANGES" ]] ||
  ! git reset -q --hard f919a6a4b1711c29fcefebcdf89a7f5eae2a7a41 ||
  ! git clean -q -fd ||
  { [[ -s "$AGENT_CHANGES" ]] && ! git apply --binary --whitespace=nowarn "$AGENT_CHANGES"; } ||
  ! find . \( -path '*/build/test-results' -o -path '*/target/surefire-reports' \
    -o -path '*/target/failsafe-reports' \) -type d -prune -exec rm -rf {} +; then
  echo "ERROR: cannot restore the agent's changes from $AGENT_CHANGES." >&2
  rm -f /logs/verifier/reward.txt
  exit 1
fi

test_files=()
while IFS= read -r diff_header; do
  if [[ "$diff_header" != "diff --git a/"* ]]; then
    continue
  fi

  diff_paths="${diff_header#diff --git a/}"
  old_path="${diff_paths%% b/*}"
  new_path="${diff_paths#* b/}"
  test_files+=("$old_path")

  if [[ "$new_path" != "$old_path" ]]; then
    test_files+=("$new_path")
  fi
done < /tests/test.patch

# Restore patch-managed files so agent changes cannot block the oracle patch.
for f in "${test_files[@]}"; do
  if git restore --source=HEAD -- "$f" 2>/dev/null; then
    continue
  fi

  git rm --cached -f -- "$f" 2>/dev/null || true
  rm -f -- "$f" || exit 1
done
git apply --whitespace=nowarn /tests/test.patch


./gradlew cleanTest test --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} + || true

XML_OUT=/logs/verifier/all-testsuites.xml
if bash /tests/kotlin_logs_collector.sh --root . --output "$XML_OUT" 2>/dev/null; then
  python3 /tests/junit_compare.py \
    --xml      "$XML_OUT" \
    --expected /tests/expected_tests.json \
    --reward   /logs/verifier/reward.txt
fi
