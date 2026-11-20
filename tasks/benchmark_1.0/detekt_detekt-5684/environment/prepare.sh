#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 0123c85b1698ffb78fc6151e7317f55449bb5171
bash /home/check_git_changes.sh

./gradlew clean test

