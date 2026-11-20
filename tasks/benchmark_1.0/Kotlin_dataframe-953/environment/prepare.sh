#!/bin/bash
set -e

cd /home/dataframe
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 7695fb290f6588d00ce3d5033c542141aaec4b3d
bash /home/check_git_changes.sh

./gradlew clean test

