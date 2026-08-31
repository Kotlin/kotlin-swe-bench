#!/bin/bash
set -euo pipefail

rm -rf /logs/verifier && mkdir -p /logs/verifier
echo 0 > /logs/verifier/reward.txt

# Apply the test patch an run the tests (repo-specific)
cd /home/dataframe
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
if ! git apply --whitespace=nowarn /tests/test.patch; then
  echo "ERROR: hidden test patch did not apply; reward remains 0." >&2
  exit 1
fi

# Remove stale JUnit reports so only this run's results can score.
find . -type f -path '*/build/test-results/*/TEST*.xml' -delete
./gradlew clean test --continue || true

# Collect JUnit XML from build output directories
XML_OUT=/logs/verifier/all-testsuites.xml
if bash /tests/kotlin_logs_collector.sh --root . --output "$XML_OUT" 2>/dev/null; then
  # Parse XML and compare against expected bench tests
  python3 /tests/junit_compare.py \
    --xml      "$XML_OUT" \
    --expected /tests/expected_tests.json \
    --reward   /logs/verifier/reward.txt
fi
