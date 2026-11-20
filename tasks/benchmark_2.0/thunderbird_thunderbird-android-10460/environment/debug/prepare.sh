#!/bin/bash
set -e

cd /home/thunderbird-android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout daffc4844d83a7a26dfedbc879d181fd95befb7a
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/thunderbird-android

# Enable the Gradle build cache so the compile output warmed here is reused by the run scripts
mkdir -p "$GRADLE_USER_HOME"
grep -qxF 'org.gradle.caching=true' "$GRADLE_USER_HOME/gradle.properties" 2>/dev/null || \
  echo 'org.gradle.caching=true' >> "$GRADLE_USER_HOME/gradle.properties"

# Fix: ensure minSdk is at least 26 to be compatible with mozilla.components library requirements
find . \( -name "*.kt" -o -name "*.gradle" -o -name "*.gradle.kts" \) |   xargs grep -l "minSdk\|sdkMin" 2>/dev/null |   xargs sed -i -E 's/(minSdk([Vv]ersion)?\s*[=]?\s*)[0-9]+/\126/g;s/(sdkMin\s*=\s*)[0-9]+/\126/g' 2>/dev/null || true

./gradlew -I /home/harbor-gradle.init.gradle harborCompileDebugUnitTests \
  --configuration-cache --max-workers=2 --continue --build-cache
./gradlew -I /home/harbor-gradle.init.gradle harborDebugUnitTests \
  --dry-run --configuration-cache --max-workers=2 --continue --build-cache

find . -type d \( \
  -path '*/build/outputs/apk' -o \
  -path '*/build/reports' -o \
  -path '*/build/test-results' \
\) -prune -exec rm -rf -- {} +

# Prune redundant Gradle artifacts (keep the dependency cache and build cache needed for offline runs)
rm -rf "$GRADLE_USER_HOME"/wrapper/dists/*/*.zip "$GRADLE_USER_HOME"/daemon "$GRADLE_USER_HOME"/native 2>/dev/null || true
