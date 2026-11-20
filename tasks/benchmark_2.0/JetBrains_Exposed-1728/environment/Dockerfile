FROM docker.io/swerebenchv2/jetbrains-exposed:1728-b4cbe97
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /Exposed
RUN mkdir -p /reference-projects/exposed-primary-key-repro /tmp/reference-project \
    && git init -q /tmp/reference-project \
    && git -C /tmp/reference-project remote add origin https://github.com/zuzkins/exposed-primary-key-repro.git \
    && git -C /tmp/reference-project fetch -q --depth=1 origin ec66c5fe043d4ce20ea8355b4695999c91864d2c \
    && git -C /tmp/reference-project archive --format=tar --output=/tmp/reference-project.tar FETCH_HEAD \
    && tar -xf /tmp/reference-project.tar -C /reference-projects/exposed-primary-key-repro \
    && rm -rf /tmp/reference-project /tmp/reference-project.tar
WORKDIR /Exposed
