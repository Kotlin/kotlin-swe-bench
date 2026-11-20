#!/bin/bash
set -e

cd /home/partiql-lang-kotlin
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout fc208aac0a500880a8625e2d2cc205b830afdffc
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/partiql-lang-kotlin

./gradlew test --no-daemon --console=plain && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

