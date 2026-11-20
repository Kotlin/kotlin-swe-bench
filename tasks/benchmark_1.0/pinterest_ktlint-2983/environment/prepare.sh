#!/bin/bash
set -e

cd /home/ktlint
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout eab1e9dfd37386c417dad06ca9386efb84878c61
bash /home/check_git_changes.sh

export CLI_TEST_MAX_DURATION_IN_SECONDS=60
./gradlew clean test

