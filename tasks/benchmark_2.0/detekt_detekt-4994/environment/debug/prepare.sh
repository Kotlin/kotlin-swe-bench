#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 4441bc403e3f08122a24c5be0eeee06813916df4
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/detekt

./gradlew clean test

