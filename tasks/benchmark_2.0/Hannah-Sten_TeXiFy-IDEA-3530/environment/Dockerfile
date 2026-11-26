FROM ghcr.io/jetbrains/kotlin-swe-bench-2/hannah-sten_texify-idea:persistent-pr-3530
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/TeXiFy-IDEA
WORKDIR /home/TeXiFy-IDEA
