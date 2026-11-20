FROM docker.io/swerebenchv2/arkivanov-decompose:734-6f24983
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /Decompose
COPY task-assets/instruction/ /task-assets/instruction/
WORKDIR /Decompose
RUN tracked="$(git status --porcelain --untracked-files=no)" \
 && ./gradlew --version --no-daemon \
 && ./gradlew :decompose:jvmTestClasses --no-daemon --console=plain \
 && { ./gradlew :decompose:jvmTest --no-daemon --console=plain || true; } \
 && find . -path '*/build/test-results/*' -name '*.xml' -delete \
 && test "$tracked" = "$(git status --porcelain --untracked-files=no)"
