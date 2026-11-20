#!/bin/bash
set -e

cd /home/kotlin-multiplatform-bignum
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout de09e09803bb1dcd2298f55cb23b054a23da7790
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/kotlin-multiplatform-bignum

./gradlew jvmTest --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results*' -exec cat {} +

