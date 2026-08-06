#!/bin/bash
set -uo pipefail

mkdir -p /logs/verifier

# Apply the test patch an run the tests (repo-specific)
cd /home/ort
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

JDK_JAVA_OPTIONS="--add-opens=java.base/java.util=ALL-UNNAMED" ./gradlew clean test --max-workers=2 --continue --init-script /home/exclude-flaky-tests.gradle || true
exit_code=$?

# Collect JUnit XML from build output directories
XML_OUT=/logs/verifier/all-testsuites.xml
if bash /tests/kotlin_logs_collector.sh --root . --output "$XML_OUT" 2>/dev/null; then
  # Parse XML and compare against expected bench tests
  python3 /tests/junit_compare.py \
    --xml      "$XML_OUT" \
    --expected /tests/expected_tests.json \
    --reward   /logs/verifier/reward.txt
else
  # Fallback: no JUnit XML found — use exit code
  echo "WARNING: JUnit XML collection failed; falling back to exit-code reward." >&2
  if [ $exit_code -eq 0 ]; then
    echo 1 > /logs/verifier/reward.txt
  else
    echo 0 > /logs/verifier/reward.txt
  fi
fi
