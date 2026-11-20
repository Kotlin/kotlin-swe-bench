FROM docker.io/swerebenchv2/graphql-java-kickstart-graphql-java-tools:593-004c964
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /graphql-java-tools
WORKDIR /graphql-java-tools
