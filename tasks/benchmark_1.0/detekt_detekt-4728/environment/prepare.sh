#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 683e696375fa5e99fec7e8677c46b0925436454d
bash /home/check_git_changes.sh

./gradlew clean test

