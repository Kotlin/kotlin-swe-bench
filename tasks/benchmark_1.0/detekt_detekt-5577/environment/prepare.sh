#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6985de34428b49eece65737977872710a8ff5510
bash /home/check_git_changes.sh

./gradlew clean test

