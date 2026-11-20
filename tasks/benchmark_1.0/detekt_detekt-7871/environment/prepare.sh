#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout a4ec32a2a496439a2580951f4c340146a0e3d610
bash /home/check_git_changes.sh

./gradlew clean test

