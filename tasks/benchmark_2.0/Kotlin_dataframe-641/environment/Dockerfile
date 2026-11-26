FROM ghcr.io/jetbrains/kotlin-swe-bench-2/kotlin_dataframe:persistent-pr-641
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/dataframe
WORKDIR /home/dataframe
