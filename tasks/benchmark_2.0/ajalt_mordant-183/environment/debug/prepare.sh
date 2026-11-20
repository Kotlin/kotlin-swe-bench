#!/bin/bash
set -e

cd /home/mordant
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 687e8ebeade95ca97a5eef8f246a0c711b1f088f
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/mordant

./gradlew :mordant:jvmTest --no-daemon --console=plain && find ./mordant/build/test-results/jvmTest -name '*.xml' -exec cat {} +

