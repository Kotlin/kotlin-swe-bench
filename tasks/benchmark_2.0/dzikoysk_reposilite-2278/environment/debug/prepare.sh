#!/bin/bash
set -e

cd /home/reposilite
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 5a421fd4d0e5259aa4b645cb39ac0b16f0e9de88
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/reposilite

./gradlew clean test

