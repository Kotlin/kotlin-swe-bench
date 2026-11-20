#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout ea6737f422e1b104898a693d5b7646cacf2c069d
bash /home/check_git_changes.sh

./gradlew clean test

