#!/bin/bash
set -e

cd /home/javalin
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout eae36464e4bd062fe59e34d0b05a051cc083a3c9
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/javalin

./mvnw test -B && find . -name 'TEST*.xml' -exec cat {} +

