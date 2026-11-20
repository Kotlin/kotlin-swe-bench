#!/bin/bash
set -e

cd /home/dataframe
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 0f88b555e2ded754840a445d8d1ef7d68f17b024
bash /home/check_git_changes.sh

./gradlew clean test

