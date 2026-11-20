FROM docker.io/swerebenchv2/partiql-partiql-lang-kotlin:1792-5200030
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /partiql-lang-kotlin
WORKDIR /partiql-lang-kotlin

# The agent sandbox has no network, so everything it needs to build and test
# against must already be in this image's Gradle cache (GRADLE_USER_HOME, set
# by the base image). The base image's cache was warmed only partially -- the
# ktlint toolchain, antlr, kotlin-stdlib-jdk8 and the immutable-collections
# artifacts were missing -- and `test` runs ktlintCheck before it and finalizes
# with jacocoTestReport, so all of that has to be cached too. Warm with the
# verifier's own lifecycle while the build still has network (test failures
# are expected on the unfixed code, so the warm tolerates them; resolution
# failures it hides are what the check below catches), then prove the cache
# suffices offline: --rerun-tasks forces the re-resolution that up-to-date
# checks would otherwise skip, and the init script makes verification
# failures non-fatal, so a failed check means exactly one thing -- the cache
# is incomplete -- and fails this image build instead of surfacing as an
# agent failure hours later.
RUN ./gradlew --no-daemon --console=plain --continue test || true
RUN printf '%s\n' 'allprojects { tasks.withType(VerificationTask).configureEach { ignoreFailures = true } }' > /tmp/smoke.init.gradle \
    && ./gradlew --no-daemon --console=plain --continue --offline -I /tmp/smoke.init.gradle --rerun-tasks test
