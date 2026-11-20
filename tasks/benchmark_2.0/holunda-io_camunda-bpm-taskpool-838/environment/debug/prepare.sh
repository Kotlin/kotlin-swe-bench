#!/bin/bash
set -e

cd /home/camunda-bpm-taskpool
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout bd9a31fc7c604b49aace8e5e43fe6367a7ac5720
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/camunda-bpm-taskpool

./mvnw test -B --no-transfer-progress -Dsurefire.printSummary=true && find . -name '*.xml' -path '*/surefire-reports/*' -exec cat {} +

