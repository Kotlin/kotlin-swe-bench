#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 8a3565572208446ff769152ded9ca5bdf957f8b0
bash /home/check_git_changes.sh

./gradlew clean test

