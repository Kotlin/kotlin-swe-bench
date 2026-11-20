#!/bin/bash
set -euo pipefail

cd "$1"

base_sha="$(git rev-parse HEAD)"

# Point a single branch at the base commit and retain only tags from its history,
# discarding every ref that could reach a future commit.
git checkout -B task-base "$base_sha"
git for-each-ref --format='%(refname)' refs/heads refs/tags refs/remotes | while read -r ref; do
  [ "$ref" = "refs/heads/task-base" ] && continue
  if [[ "$ref" = refs/tags/* ]]; then
    tag_commit="$(git rev-list -n 1 "$ref")"
    git merge-base --is-ancestor "$tag_commit" "$base_sha" && continue
  fi
  git update-ref -d "$ref"
done

# Remove remotes so the future commits can't be re-fetched from origin.
git remote | while read -r name; do
  git remote remove "$name"
done

# Drop reflog entries — they can otherwise resurrect a commit that was
# checked out before the seal ran.
git reflog expire --expire=now --expire-unreachable=now --all

# Garbage-collect immediately: unreachable objects (future commits and
# anything only reachable from them) are deleted now, not after git's
# default two-week grace period.
git gc --prune=now
