#!/bin/bash
set -e

cd /home/TeXiFy-IDEA
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 73563f0c6548d52493991da31d073aa6018afe5d
bash /home/check_git_changes.sh

./gradlew clean test --init-script /home/exclude-flaky-tests.gradle.kts || true

