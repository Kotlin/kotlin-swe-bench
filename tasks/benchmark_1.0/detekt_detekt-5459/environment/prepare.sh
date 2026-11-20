#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 0a3da653d770affa229eaa4f275027ffd4a2f22b
bash /home/check_git_changes.sh

./gradlew clean test

