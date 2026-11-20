#!/bin/bash
set -e

cd /home/dataframe
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 1d2eb2ef79b451664dfc731a2f5cb78117e16e4b
bash /home/check_git_changes.sh

./gradlew clean test

