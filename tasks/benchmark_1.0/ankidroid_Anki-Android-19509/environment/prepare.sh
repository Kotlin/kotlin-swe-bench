#!/bin/bash
set -e

cd /home/Anki-Android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout d50e845f4b0546ed24f9db8d448e94fca28fe9bf
bash /home/check_git_changes.sh

./gradlew clean jacocoUnitTestReport --continue --max-workers=2

