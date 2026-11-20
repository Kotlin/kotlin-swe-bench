#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 2866976a40c7802a2ae4670703e8373e66603dee
bash /home/check_git_changes.sh

./gradlew clean test

