#!/bin/bash
set -e

cd /home/Anki-Android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout e89660279e30c1ca46faf10c78c456611b1aa239
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/Anki-Android

./gradlew clean jacocoUnitTestReport --continue --max-workers=2

