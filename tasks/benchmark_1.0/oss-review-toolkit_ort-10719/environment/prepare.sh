#!/bin/bash
set -e

cd /home/ort
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6569d7a105b0b08a5d14b7f7293687e8931d6b6e
bash /home/check_git_changes.sh

JDK_JAVA_OPTIONS="--add-opens=java.base/java.util=ALL-UNNAMED" ./gradlew test --continue --max-workers=2 --init-script /home/exclude-flaky-tests.gradle || true

