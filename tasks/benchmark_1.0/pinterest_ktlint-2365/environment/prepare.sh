#!/bin/bash
set -e

cd /home/ktlint
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 7c565012ebd712470dd30af48f108bc7ede2db90
bash /home/check_git_changes.sh

export CLI_TEST_MAX_DURATION_IN_SECONDS=60
./gradlew clean test

