#!/bin/bash
set -e

cd /home/kompendium
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 2e29b46f0f26e6b43f0defa6d05c2bd4f4140659
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/kompendium

./gradlew cleanTest test --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

