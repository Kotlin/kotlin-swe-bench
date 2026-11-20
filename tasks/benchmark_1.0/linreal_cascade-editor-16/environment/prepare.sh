#!/bin/bash
set -euo pipefail

readonly REPOSITORY_URL="https://github.com/linreal/cascade-editor.git"
readonly BASE_COMMIT="7b0ee98b6108167872c02d58bd6fef7fd5ea218d"
readonly REPOSITORY_DIR="/home/CascadeEditor"

assert_base_snapshot() {
  [[ "$(git rev-parse HEAD)" == "$BASE_COMMIT" ]]
  [[ "$(git rev-list --all --count)" == "1" ]]
  [[ -z "$(git for-each-ref --format='%(refname)' refs/heads refs/remotes refs/tags)" ]]
  [[ -z "$(git remote)" ]]
  [[ -z "$(git reflog show --all)" ]]
  [[ -z "$(git fsck --no-reflogs --unreachable 2>/dev/null)" ]]
}

git init "$REPOSITORY_DIR"
cd "$REPOSITORY_DIR"
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude

# Fetch only the exact base commit. Do not leave a remote, tags, branches,
# reflogs, unreachable objects, or later source history in the task image.
git remote add origin "$REPOSITORY_URL"
git fetch --depth=1 --no-tags origin "$BASE_COMMIT"
git checkout --detach FETCH_HEAD
git remote remove origin
rm -f .git/FETCH_HEAD
git reflog expire --expire=now --all
git gc --prune=now
assert_base_snapshot
bash /home/check_git_changes.sh

# Warm the historical suite first, then the Compose Desktop test dependencies
# used only by the hidden verifier. Restore the exact base tree afterwards;
# Gradle's dependency cache remains in the image for network-free verification.
./gradlew :editor:desktopTest --no-daemon
git apply /home/warm-compose-ui-test.patch
xvfb-run -a ./gradlew :editor:desktopTest --no-daemon
git reset --hard
git clean -fd
git reflog expire --expire=now --all
git gc --prune=now
assert_base_snapshot
bash /home/check_git_changes.sh
