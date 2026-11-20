#!/bin/bash
set -e

cd /home/TeXiFy-IDEA
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout ad00409f9ff6841e131d4d41a391a20a0c2b3e52
bash /home/check_git_changes.sh

./gradlew clean test --init-script /home/exclude-flaky-tests.gradle.kts || true

