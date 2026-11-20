#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout b6437723aea286fc6157817848e10b3851fcb388
bash /home/check_git_changes.sh

./gradlew clean test

