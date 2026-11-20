FROM docker.io/swerebenchv2/tipsy-javalin:1984-eae3646
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /javalin
WORKDIR /javalin

# The agent sandbox has no network, so everything it needs to build and test
# against must already be in this image's Maven cache. This base's cache is
# already complete -- the corpus builders ran the full test lifecycle -- which
# is why runs against this revision worked while 1952's failed. Keep it that
# way by contract rather than by accident: warm with the verifier's own
# lifecycle, then prove the cache suffices offline. A failed check fails this
# image build instead of surfacing as an agent failure hours later; test
# failures are expected on the unfixed code, so both runs tolerate them, and
# the warm tolerates a crash of its own -- the offline run is the gate, and a
# resolution failure there is always fatal. The verifier resets the git tree
# and drops any baked surefire reports before its own run, so the reports
# these steps leave behind cannot leak into a score.
RUN ./mvnw -B -ntp -Dmaven.test.failure.ignore=true test || true
RUN ./mvnw -B -ntp -o -Dmaven.test.failure.ignore=true test
