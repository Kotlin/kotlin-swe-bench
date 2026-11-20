#!/bin/bash
set -e

cd /home/reposilite
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 731001f29eabf37e29259c409f8806b40748a0db
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/reposilite

./gradlew clean test

