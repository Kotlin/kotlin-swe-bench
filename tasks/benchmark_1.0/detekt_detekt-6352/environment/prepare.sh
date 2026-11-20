#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 432121310b409f45eab04bd91096dac830b728ba
bash /home/check_git_changes.sh

./gradlew clean test

