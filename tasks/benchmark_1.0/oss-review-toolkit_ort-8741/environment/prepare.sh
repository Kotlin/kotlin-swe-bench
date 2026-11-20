#!/bin/bash
set -e

cd /home/ort
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout e20d80f0a0c92fb1d1da61fab577fe4a2fbdcd0c
bash /home/check_git_changes.sh

JDK_JAVA_OPTIONS="--add-opens=java.base/java.util=ALL-UNNAMED" ./gradlew test --continue --max-workers=2 --init-script /home/exclude-flaky-tests.gradle || true

