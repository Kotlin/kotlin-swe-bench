#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout cb050a10df93da3c98742f7d86de46df1e771897
bash /home/check_git_changes.sh

./gradlew clean test

