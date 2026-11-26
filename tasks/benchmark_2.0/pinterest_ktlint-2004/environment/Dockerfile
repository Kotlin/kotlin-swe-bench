FROM ghcr.io/jetbrains/kotlin-swe-bench-2/pinterest_ktlint:persistent-pr-2004
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/ktlint
WORKDIR /home/ktlint
