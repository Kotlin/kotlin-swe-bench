#!/bin/bash
set -e

cd /home/TeXiFy-IDEA
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout fbbcad2588a0c2582352722aaced65d8ec37f7c7
bash /home/check_git_changes.sh

./gradlew clean test --init-script /home/exclude-flaky-tests.gradle.kts || true

