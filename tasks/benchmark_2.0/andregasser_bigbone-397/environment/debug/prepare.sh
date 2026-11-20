#!/bin/bash
set -e

cd /home/bigbone
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 8005e691475f0321445e62907706891c497ae1f0
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/bigbone

./gradlew check --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

