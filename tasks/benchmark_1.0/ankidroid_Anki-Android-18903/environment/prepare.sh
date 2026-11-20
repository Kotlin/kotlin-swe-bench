#!/bin/bash
set -e

cd /home/Anki-Android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout e4b78d0dbaa1f48b0a3aac89ac9fdd914d4aa38e
bash /home/check_git_changes.sh

./gradlew clean jacocoUnitTestReport --continue --max-workers=2

