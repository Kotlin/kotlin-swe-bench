#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout bd922af416fb3e28e4d5220ac693e1ae1a721bee
bash /home/check_git_changes.sh

./gradlew clean test

