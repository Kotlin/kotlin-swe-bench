#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout d4f3f99ca335a36d596007685d705d0d69f65c01
bash /home/check_git_changes.sh

./gradlew clean test

