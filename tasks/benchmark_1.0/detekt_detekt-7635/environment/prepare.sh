#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout d53028caa506a25443e9ea9c1498329daf94b001
bash /home/check_git_changes.sh

./gradlew clean test

