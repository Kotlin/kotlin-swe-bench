#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 82ab4c5ac06f006a0906920687dc016af37642a6
bash /home/check_git_changes.sh

./gradlew clean test

