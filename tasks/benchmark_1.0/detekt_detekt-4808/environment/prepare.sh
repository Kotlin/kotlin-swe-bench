#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 30af7dc16e616e05b29736c4900e68730f7d57ba
bash /home/check_git_changes.sh

./gradlew clean test

