#!/bin/bash
set -e

cd /home/javalin
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout b9f881e79802ec77991666f047ec75495553a7cd
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/javalin

./mvnw test -B && find . -name 'TEST*.xml' -exec cat {} +

