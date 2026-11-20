#!/bin/bash
set -e

cd /home/github-crawler
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout b0996eab8fe6718b49348ea997f0f076812163fd
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/github-crawler

mvn test --batch-mode --no-transfer-progress -Djunit.jupiter.execution.parallel.enabled=false -DfailIfNoTests=false

