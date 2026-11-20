#!/bin/bash
set -e

cd /home/ort
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 920fd0ccb5667526003ec17fe40d9117e83e990f
bash /home/check_git_changes.sh

JDK_JAVA_OPTIONS="--add-opens=java.base/java.util=ALL-UNNAMED" ./gradlew test --continue --max-workers=2 --init-script /home/exclude-flaky-tests.gradle || true

