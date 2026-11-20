#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 146a13e22940bee5562c3a5c6f94e3627ab859c5
bash /home/check_git_changes.sh

./gradlew clean test

