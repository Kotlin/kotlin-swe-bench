#!/bin/bash
set -e

cd /home/redwood
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 9f94d885d33e3a651d42cf5031825afc97b31a2b
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/redwood

./gradlew jvmTest --no-daemon --console=plain -PredwoodNoSamples && find . -name '*.xml' -path '*/test-results/*' -exec cat {} +

