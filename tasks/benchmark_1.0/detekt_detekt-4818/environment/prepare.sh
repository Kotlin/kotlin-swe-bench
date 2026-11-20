#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout d0d34c1dc3510ab41eca6384547c84f4b22953c2
bash /home/check_git_changes.sh

./gradlew clean test

