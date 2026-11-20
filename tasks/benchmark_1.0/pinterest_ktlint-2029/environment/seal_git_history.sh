#!/bin/bash
set -euo pipefail

# Seal the task checkout so only the pinned base commit (and its ancestors)
# remain reachable. Every later commit -- notably the published upstream fix --
# becomes unreferenced and is pruned, and no remote is left to re-fetch it.
cd "$1"

base_sha="$(git rev-parse HEAD)"

# Point a single branch at the base commit -- the only ref left standing --
# discarding every other local branch/tag/remote-tracking ref that could reach
# a future commit.
git checkout -B task-base "$base_sha"
git for-each-ref --format='%(refname)' refs/heads refs/tags refs/remotes | while read -r ref; do
  [ "$ref" = "refs/heads/task-base" ] && continue
  git update-ref -d "$ref"
done

# Remove remotes so the future commits can't be re-fetched from origin.
git remote | while read -r name; do
  git remote remove "$name"
done

# Drop reflog entries -- they can otherwise resurrect a commit that was
# checked out before the seal ran.
git reflog expire --expire=now --expire-unreachable=now --all

# Garbage-collect immediately: unreachable objects (future commits and anything
# only reachable from them) are deleted now, not after git's default grace period.
git gc --prune=now

# Post-conditions: fail the build loudly if the seal did not hold.
[ "$(git rev-parse HEAD)" = "$base_sha" ] || { echo "seal: HEAD moved" >&2; exit 1; }
[ -z "$(git remote)" ] || { echo "seal: a remote survived" >&2; exit 1; }
[ -z "$(git for-each-ref --format='%(refname)' refs/remotes refs/tags)" ] || {
  echo "seal: a remote-tracking or tag ref survived" >&2; exit 1; }
[ "$(git for-each-ref --format='%(refname)' refs/heads)" = "refs/heads/task-base" ] || {
  echo "seal: an unexpected local branch survived" >&2; exit 1; }
