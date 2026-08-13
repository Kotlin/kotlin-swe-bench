#!/bin/bash
set -uo pipefail

mkdir -p /logs/verifier

cd /home/CascadeEditor
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

xvfb-run -a ./gradlew clean :editor:desktopTest --offline --no-daemon --continue || true

XML_OUT=/logs/verifier/all-testsuites.xml
if bash /tests/kotlin_logs_collector.sh --root . --output "$XML_OUT" 2>/dev/null; then
  python3 /tests/junit_compare.py \
    --xml "$XML_OUT" \
    --expected /tests/expected_tests.json \
    --reward /logs/verifier/reward.txt
else
  echo "WARNING: JUnit XML collection failed; reward is 0." >&2
  echo 0 > /logs/verifier/reward.txt
fi
