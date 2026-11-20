#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 1e696fd9fca384060f3e03a7711318f00523b93f
bash /home/check_git_changes.sh

./gradlew clean test

