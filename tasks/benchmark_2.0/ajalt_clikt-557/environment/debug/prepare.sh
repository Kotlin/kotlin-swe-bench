#!/bin/bash
set -e

cd /home/clikt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6812854304b20807e7f20880a8ee4b8097ae33b0
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/clikt

./gradlew :test:jvmTest --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

