#!/bin/bash
set -e

cd /home/Anki-Android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 77002d5b4331568249dd47c2db6d3a906c960c73
bash /home/check_git_changes.sh

./gradlew clean jacocoUnitTestReport --continue --max-workers=2

