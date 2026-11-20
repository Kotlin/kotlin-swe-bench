#!/bin/bash
set -e

cd /home/Reaktive
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 6c1f29e1c385a0e7fc3ca648d21d0ae284105b44
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/Reaktive

./gradlew :reaktive:jvmTest :reaktive-testing:jvmTest :reaktive-annotations:jvmTest :coroutines-interop:jvmTest --no-daemon --console=plain --info && find . -name 'TEST-*.xml' -exec cat {} \; || true

