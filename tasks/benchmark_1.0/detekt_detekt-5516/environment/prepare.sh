#!/bin/bash
set -e

cd /home/detekt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 1aa48c375e1be3ac39a80f35b2d7100f21bb6706
bash /home/check_git_changes.sh

./gradlew clean test

