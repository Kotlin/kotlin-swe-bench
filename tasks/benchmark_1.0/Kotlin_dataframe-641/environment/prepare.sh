#!/bin/bash
set -e

cd /home/dataframe
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 9de12a32af25942caccc2f52a2b8ae98802212fb
bash /home/check_git_changes.sh

./gradlew clean test

