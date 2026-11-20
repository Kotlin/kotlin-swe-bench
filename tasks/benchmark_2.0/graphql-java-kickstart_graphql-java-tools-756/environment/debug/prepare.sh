#!/bin/bash
set -e

cd /home/graphql-java-tools
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 8b6971f5f72c3951c97d46ea72e37fec44c87d84
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/graphql-java-tools

mvn --batch-mode test --no-transfer-progress -Dmaven.repo.local=/tmp/m2 -Dsurefire.printSummary=true --show-version --errors

