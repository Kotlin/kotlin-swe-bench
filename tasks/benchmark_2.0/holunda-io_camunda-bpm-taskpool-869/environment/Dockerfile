FROM docker.io/swerebenchv2/holunda-io-camunda-bpm-taskpool:869-c259133
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /camunda-bpm-taskpool
WORKDIR /camunda-bpm-taskpool
