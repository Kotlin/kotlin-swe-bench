#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 7f5799dd496e63648212550b5a3d3c7cac9b77ff
bash /home/check_git_changes.sh

./gradlew clean test

