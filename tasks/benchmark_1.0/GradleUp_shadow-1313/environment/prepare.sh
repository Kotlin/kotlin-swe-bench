#!/bin/bash
set -e

cd /home/shadow
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout b9d4a93656f1ba66929195e2e244bbd1edcc589c
bash /home/check_git_changes.sh

./gradlew clean test

