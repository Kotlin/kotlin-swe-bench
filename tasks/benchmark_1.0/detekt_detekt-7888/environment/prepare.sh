#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6c8f571d886aa581b62b02964e00ef7008559e72
bash /home/check_git_changes.sh

./gradlew clean test

