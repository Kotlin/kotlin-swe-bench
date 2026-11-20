FROM docker.io/swerebenchv2/partiql-partiql-lang-kotlin:1716-fc208aa
ENV _JAVA_OPTIONS=-Djava.net.preferIPv4Stack=true
RUN apt-get update -qq && apt-get install -y --no-install-recommends python3 && rm -rf /var/lib/apt/lists/*
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /partiql-lang-kotlin
WORKDIR /partiql-lang-kotlin
