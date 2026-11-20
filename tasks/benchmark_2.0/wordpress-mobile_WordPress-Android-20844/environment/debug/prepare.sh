#!/bin/bash
set -e

cd /home/WordPress-Android
git config core.autocrlf input
git config core.filemode false
echo ".gitattributes" >> .git/info/exclude
git add .
git reset --hard
bash /home/check_git_changes.sh
git checkout 06d79f64746fbb421ce1e1d7a3c694a6f00b6cef
bash /home/check_git_changes.sh
bash /home/seal_git_history.sh /home/WordPress-Android

if [ ! -f "gradle.properties" ]; then
  cat > gradle.properties << 'EOF'
org.gradle.jvmargs=-Xmx8g -XX:MaxMetaspaceSize=1g -XX:+HeapDumpOnOutOfMemoryError
org.gradle.parallel=false
org.gradle.workers.max=2
kotlin.compiler.execution.strategy=in-process
org.gradle.configureondemand=true
org.gradle.caching=true
android.useAndroidX=true
android.enableJetifier=false
android.nonTransitiveRClass=true
android.nonFinalResIds=false
android.enableR8.fullMode=false
dependency.analysis.android.ignored.variants=release,wordpressVanillaDebug,wordpressVanillaRelease,wordpressWasabiDebug,wordpressWasabiRelease,wordpressJalapenoRelease,jetpackVanillaDebug,jetpackVanillaRelease,jetpackWasabiDebug,jetpackWasabiRelease,jetpackJalapenoRelease
dependency.analysis.test.analysis=false
EOF
fi

cat > defaults.properties << 'EOF'
jp.sentry.dsn=https://00000000000000000000000000000000@sentry.io/00000000
wp.docsbotai.id=wordpress
wp.encrypted_logging_key=z0g+oVkqR4kWNUTxJfTozOZQjfXI7W9f6bD0uMJ5VkA=
wp.oauth.app_id=wordpress
wp.oauth.app_secret=wordpress
wp.reset_db_on_downgrade=false
wp.sentry.dsn=https://00000000000000000000000000000000@sentry.io/00000000
wp.tenor.api_key=wordpress
wp.zendesk.app_id=wordpress
wp.zendesk.domain=https://www.google.com/
wp.zendesk.oauth_client_id=wordpress
wp.e2e.self_hosted_user.password=e2e_placeholder
wp.e2e.self_hosted_user.site_address=e2e_placeholder
wp.e2e.self_hosted_user.username=e2e_placeholder
wp.e2e.signup.display_name=e2e_placeholder
wp.e2e.signup.email=e2e_placeholder@example.com
wp.e2e.signup.password=e2e_placeholder
wp.e2e.signup.username=e2e_placeholder
wp.e2e.wp_com_passwordless_user.email=e2e_placeholder@example.com
wp.e2e.wp_com_user.email=e2e_placeholder@example.com
wp.e2e.wp_com_user.password=e2e_placeholder
wp.e2e.wp_com_user.site_address=e2e_placeholder
wp.e2e.wp_com_user.username=e2e_placeholder
EOF

# Also append wp./jp. properties to gradle.properties for older SHAs that read from there
grep -qF "wp.zendesk.domain" gradle.properties 2>/dev/null || cat >> gradle.properties << 'EOF'
jp.sentry.dsn=https://00000000000000000000000000000000@sentry.io/00000000
wp.docsbotai.id=wordpress
wp.encrypted_logging_key=z0g+oVkqR4kWNUTxJfTozOZQjfXI7W9f6bD0uMJ5VkA=
wp.oauth.app_id=wordpress
wp.oauth.app_secret=wordpress
wp.reset_db_on_downgrade=false
wp.sentry.dsn=https://00000000000000000000000000000000@sentry.io/00000000
wp.tenor.api_key=wordpress
wp.zendesk.app_id=wordpress
wp.zendesk.domain=https://www.google.com/
wp.zendesk.oauth_client_id=wordpress
wp.e2e.self_hosted_user.password=e2e_placeholder
wp.e2e.self_hosted_user.site_address=e2e_placeholder
wp.e2e.self_hosted_user.username=e2e_placeholder
wp.e2e.signup.display_name=e2e_placeholder
wp.e2e.signup.email=e2e_placeholder@example.com
wp.e2e.signup.password=e2e_placeholder
wp.e2e.signup.username=e2e_placeholder
wp.e2e.wp_com_passwordless_user.email=e2e_placeholder@example.com
wp.e2e.wp_com_user.email=e2e_placeholder@example.com
wp.e2e.wp_com_user.password=e2e_placeholder
wp.e2e.wp_com_user.site_address=e2e_placeholder
wp.e2e.wp_com_user.username=e2e_placeholder
EOF

./gradlew :WordPress:assembleWordpressVanillaDebug --max-workers=2 --build-cache

# Prune redundant Gradle artifacts (keep the dependency cache and build cache needed for offline runs)
rm -rf "$GRADLE_USER_HOME"/wrapper/dists/*/*.zip "$GRADLE_USER_HOME"/daemon "$GRADLE_USER_HOME"/native 2>/dev/null || true

