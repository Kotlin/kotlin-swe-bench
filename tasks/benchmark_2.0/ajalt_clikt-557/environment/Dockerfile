FROM docker.io/swerebenchv2/ajalt-clikt:557-6812854
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /clikt
WORKDIR /clikt
RUN tracked="$(git status --porcelain --untracked-files=no)" \
 && ./gradlew --version --no-daemon \
 && ./gradlew :test:jvmTestClasses --no-daemon --console=plain \
 && { ./gradlew :test:jvmTest --no-daemon --console=plain || true; } \
 && find . -path '*/build/test-results/*' -name '*.xml' -delete \
 && test "$tracked" = "$(git status --porcelain --untracked-files=no)"
