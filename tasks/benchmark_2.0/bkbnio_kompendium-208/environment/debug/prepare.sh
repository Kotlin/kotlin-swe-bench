#!/bin/bash
set -e

cd /home/kompendium
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout f919a6a4b1711c29fcefebcdf89a7f5eae2a7a41
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/kompendium

./gradlew cleanTest test --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

