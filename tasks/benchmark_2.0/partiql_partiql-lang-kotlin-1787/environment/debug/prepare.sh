#!/bin/bash
set -e

cd /home/partiql-lang-kotlin
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout fec65b77f5e3c0bb2721450bbb8977b102fef1a6
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/partiql-lang-kotlin

./gradlew test --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

