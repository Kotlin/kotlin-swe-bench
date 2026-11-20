FROM docker.io/swerebenchv2/badoo-reaktive:781-6c1f29e
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /Reaktive
WORKDIR /Reaktive
RUN tracked="$(git status --porcelain --untracked-files=no)" \
 && ./gradlew --version --no-daemon \
 && ./gradlew :reaktive:jvmTestClasses :reaktive-testing:jvmTestClasses :reaktive-annotations:jvmTestClasses :coroutines-interop:jvmTestClasses --no-daemon --console=plain \
 && { ./gradlew :reaktive:jvmTest :reaktive-testing:jvmTest :reaktive-annotations:jvmTest :coroutines-interop:jvmTest --no-daemon --console=plain || true; } \
 && find . -path '*/build/test-results/*' -name '*.xml' -delete \
 && test "$tracked" = "$(git status --porcelain --untracked-files=no)"
