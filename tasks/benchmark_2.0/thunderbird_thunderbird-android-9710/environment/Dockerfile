FROM europe-west4-docker.pkg.dev/gke-dev-dws-jbr/ml/kotlinai/thunderbird_thunderbird-android:persistent-pr-9710
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/thunderbird-android
COPY task-assets/instruction/ /task-assets/instruction/
WORKDIR /home/thunderbird-android

# The agent sandbox has no network, so everything it needs to build and test
# against must already be in this image's Gradle cache (GRADLE_USER_HOME, set
# by the base image) -- and Android unit tests additionally fetch Robolectric's
# android-all jars from Maven Central at test execution time, into ~/.m2,
# which the base image never did. Warm with the verifier's own aggregate (the
# init script copied beside this Dockerfile is byte-identical to the one the
# verifier installs) while the build still has network; test failures are
# expected on the unfixed code, so the warm tolerates them. The offline check
# then proves the cache suffices to compile every debug unit test, and that
# the Robolectric jars really are in the Maven cache -- a failed check fails
# this image build instead of surfacing as an agent failure hours later.
# (This task's base image is on a private registry, so unlike the others it
# could not be validated locally.)
COPY debug/harbor-gradle.init.gradle /tmp/harbor-gradle.init.gradle
RUN ./gradlew --no-daemon --console=plain --continue --max-workers=4 -I /tmp/harbor-gradle.init.gradle harborDebugUnitTests || true
RUN ./gradlew --no-daemon --console=plain --continue --offline --rerun-tasks -I /tmp/harbor-gradle.init.gradle harborCompileDebugUnitTests \
    && find /root/.m2 /home -type f -path '*org/robolectric/android-all*' -name '*.jar' -print -quit | grep -q .
