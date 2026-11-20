#!/bin/bash
set -e

cd /home/Decompose
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6f24983cb1e00f67443148967e5d30769eeb068a
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/Decompose

./gradlew :decompose:jvmTest --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} \;

