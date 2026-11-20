#!/bin/bash
set -e

cd /home/ktlint
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6500181e1652383d1eb29d2feb84aad9f2897921
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/ktlint

export CLI_TEST_MAX_DURATION_IN_SECONDS=60
./gradlew clean test

