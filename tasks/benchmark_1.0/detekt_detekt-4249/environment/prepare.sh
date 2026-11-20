#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6e203211aee34495f50c812807d8c195a563f2c4
bash /home/check_git_changes.sh

./gradlew clean test

