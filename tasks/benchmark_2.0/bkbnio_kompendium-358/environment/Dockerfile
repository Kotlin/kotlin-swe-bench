FROM docker.io/swerebenchv2/bkbnio-kompendium:358-e421784
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /kompendium
WORKDIR /kompendium

# The base image ships only Temurin 21, but this revision's Gradle wrapper
# (7.5.1) cannot run on anything newer than Java 18: it dies compiling its
# own scripts ("Unsupported class file major version 65") before any task
# executes. The warm's `|| true` silently swallowed this; the offline gate
# caught it on 2026-11-09. Install the LTS the project was developed against
# (present in the base image's own apt, noble main) and pin it. gradlew
# honours JAVA_HOME for the warm, the gate, the agent and the verifier
# alike, and task.toml sets nothing that overrides it.
RUN apt-get update -qq && apt-get install -y --no-install-recommends openjdk-17-jdk-headless && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# The agent sandbox has no network, so everything it needs to build and test
# against must already be in this image's Gradle cache (GRADLE_USER_HOME, set
# by the base image). The base image's cache is incomplete for this revision,
# which left both agents blocked on resolution before they could run anything.
# Warm with the verifier's own lifecycle while the build still has network;
# test failures are expected on the unfixed code, so the warm tolerates them.
# The offline check then proves the cache suffices: --rerun-tasks forces the
# re-resolution that up-to-date checks would otherwise skip, and the init
# script makes verification failures non-fatal, so a failed check means
# exactly one thing -- the cache is incomplete -- and fails this image build
# instead of surfacing as an agent failure hours later.
RUN ./gradlew --no-daemon --console=plain --continue cleanTest test || true
RUN printf '%s\n' 'allprojects { tasks.withType(VerificationTask).configureEach { ignoreFailures = true } }' > /tmp/smoke.init.gradle \
    && ./gradlew --no-daemon --console=plain --continue --offline -I /tmp/smoke.init.gradle --rerun-tasks cleanTest test
