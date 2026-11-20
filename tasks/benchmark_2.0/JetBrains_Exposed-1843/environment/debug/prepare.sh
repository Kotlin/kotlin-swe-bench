#!/bin/bash
set -e

cd /home/Exposed
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 1afd391979eed949225c8fc3f309e6515991df32
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/Exposed

./gradlew h2Test --no-daemon --console=plain && find exposed-tests/build/test-results -name '*.xml' -exec cat {} +

