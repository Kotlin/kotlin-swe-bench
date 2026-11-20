#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 5672df8d0e358c2293d7c46796984e2afb79532d
bash /home/check_git_changes.sh

./gradlew clean test

