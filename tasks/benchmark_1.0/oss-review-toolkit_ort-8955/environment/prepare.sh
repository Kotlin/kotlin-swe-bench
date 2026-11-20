#!/bin/bash
set -e

cd /home/ort
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout b0bddf9440e92c675ed3e3777cad407ec7d0e183
bash /home/check_git_changes.sh

JDK_JAVA_OPTIONS="--add-opens=java.base/java.util=ALL-UNNAMED" ./gradlew test --continue --max-workers=2 --init-script /home/exclude-flaky-tests.gradle || true

