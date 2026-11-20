#!/bin/bash
set -e

cd /home/ktoml
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout dbc5278c12c531774260091550755569f9fbfb41
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/ktoml

./gradlew allTests --no-daemon --console=plain && find . -name '*.xml' -exec cat {} + || true

