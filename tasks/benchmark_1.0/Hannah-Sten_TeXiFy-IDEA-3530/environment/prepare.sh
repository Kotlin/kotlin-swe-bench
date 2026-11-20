#!/bin/bash
set -e

cd /home/TeXiFy-IDEA
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout b084823d6b5a9f7b6c7472842f619c4449d74c77
bash /home/check_git_changes.sh

./gradlew clean test --init-script /home/exclude-flaky-tests.gradle.kts || true

