FROM docker.io/swerebenchv2/cashapp-redwood:870-9f94d88
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /redwood
WORKDIR /redwood
RUN tracked="$(git status --porcelain --untracked-files=no)" \
 && ./gradlew --version --no-daemon \
 && ./gradlew jvmTestClasses -PredwoodNoSamples --no-daemon --console=plain \
 && { ./gradlew jvmTest -PredwoodNoSamples --no-daemon --console=plain || true; } \
 && find . -path '*/build/test-results/*' -name '*.xml' -delete \
 && test "$tracked" = "$(git status --porcelain --untracked-files=no)"
