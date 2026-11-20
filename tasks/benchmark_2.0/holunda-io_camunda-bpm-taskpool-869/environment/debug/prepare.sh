#!/bin/bash
set -e

cd /home/camunda-bpm-taskpool
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout c259133114e1aa9e6f4984eb8576ea1783693b99
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/camunda-bpm-taskpool

./mvnw test -B --no-transfer-progress -Dsurefire.printSummary=true && find . -name '*.xml' -path '*/surefire-reports/*' -exec cat {} +

