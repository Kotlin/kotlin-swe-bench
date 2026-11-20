#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout e39010d06763597fea35f551896b0683b232c703
bash /home/check_git_changes.sh

./gradlew clean test

