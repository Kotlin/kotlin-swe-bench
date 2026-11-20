#!/bin/bash
set -e

cd /home/TeXiFy-IDEA
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 0a758c651f170efedfa95f9c8cc283ad439f650c
bash /home/check_git_changes.sh

./gradlew clean test --init-script /home/exclude-flaky-tests.gradle.kts || true

