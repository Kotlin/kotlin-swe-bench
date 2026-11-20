#!/bin/bash
set -e

cd /home/ktoml
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 7214b255fee0e438843205c6097f8ae31184b9f6
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/ktoml

./gradlew allTests --no-daemon --console=plain && find . -name '*.xml' -exec cat {} + || true

