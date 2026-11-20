#!/bin/bash
set -e

cd /home/graphql-java-tools
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 004c96447b6938f369178b230f538620b829f2a5
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/graphql-java-tools

mvn --batch-mode test --no-transfer-progress -Dmaven.repo.local=/tmp/m2 -Dsurefire.printSummary=true --show-version --errors

