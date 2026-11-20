#!/bin/bash
set -e

cd /home/supabase-kt
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 495aec15c95e78587a5161e88c4636df6e756dd6
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/supabase-kt

./gradlew jvmTest --no-daemon --console=plain -DLibrariesOnly=true && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

