#!/bin/bash
set -e

cd /home/Anki-Android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 0ef7450b619afae2aa3bfab925a3427b10031f5c
bash /home/check_git_changes.sh

./gradlew clean jacocoUnitTestReport --continue --max-workers=2

