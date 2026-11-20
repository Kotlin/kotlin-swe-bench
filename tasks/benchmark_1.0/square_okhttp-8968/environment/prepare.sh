#!/bin/bash
set -e

cd /home/okhttp
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 07fe953b40543dd2be05b785e67577f49211f485
bash /home/check_git_changes.sh

export CI=true
./gradlew clean test

