#!/bin/bash
set -e

cd /home/Anki-Android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 8bfadcbe33cb68af5caa471bdce5f80a922500bb
bash /home/check_git_changes.sh

./gradlew clean jacocoUnitTestReport --continue --max-workers=2

