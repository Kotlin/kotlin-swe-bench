#!/bin/bash
set -e

cd /home/ktlint
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 62bb733f5eb0a3f2476963cc280295c18640c01c
bash /home/check_git_changes.sh

export CLI_TEST_MAX_DURATION_IN_SECONDS=60
./gradlew clean test

