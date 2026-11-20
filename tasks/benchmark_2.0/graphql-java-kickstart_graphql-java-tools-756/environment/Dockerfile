FROM docker.io/swerebenchv2/graphql-java-kickstart-graphql-java-tools:756-8b6971f
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /graphql-java-tools
WORKDIR /graphql-java-tools

# The agent sandbox has no network, so everything it needs to build and test
# against must already be in this image's Maven cache -- and the base image
# ships none at all (only the gcs-central mirror settings), which left both
# agents unable to compile or run anything. There is no mvnw in this repo, so
# warm with the system Maven, into the default local repository the agent
# reads; the verifier itself resolves into a throwaway /tmp/m2, so this cache
# is exactly and only the agent's. Then prove the cache suffices offline,
# still with the verifier's lifecycle: that run is the gate, because a build
# that skips tests is not guaranteed to have fetched what tests need at
# execution time -- surefire's test providers among them, which one repo's
# package warm resolved and another's left missing -- and a failed check
# fails this image build instead of surfacing as an agent failure hours
# later. Both runs tolerate
# the test failures expected on the unfixed code, and the warm tolerates a
# crash of its own; a resolution failure offline is always fatal. The verifier
# resets the git tree and drops any baked surefire reports before its own
# run, so the reports these steps leave behind cannot leak into a score.
RUN mvn -B -ntp -Dmaven.test.failure.ignore=true test || true
RUN mvn -B -ntp -o -Dmaven.test.failure.ignore=true test
