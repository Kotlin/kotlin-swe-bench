#!/bin/bash
set -e

cd /home/okhttp
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 1ff16232f86d2b302840a3bb2f9d386e94374753
bash /home/check_git_changes.sh

export CI=true
./gradlew clean test

