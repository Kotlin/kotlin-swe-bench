#!/bin/bash
set -e

cd /home/ort
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 9a87295f45eea936900517006be519c2bd68d158
bash /home/check_git_changes.sh

JDK_JAVA_OPTIONS="--add-opens=java.base/java.util=ALL-UNNAMED" ./gradlew test --continue --max-workers=2 --init-script /home/exclude-flaky-tests.gradle || true

