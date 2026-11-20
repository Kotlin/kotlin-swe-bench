#!/bin/bash
set -e

cd /home/javalin
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6832e5558f784fe9d2226fd7460155131f4bd2d3
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/javalin

./mvnw test -B && find . -name 'TEST*.xml' -exec cat {} +

