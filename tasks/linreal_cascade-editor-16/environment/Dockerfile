# Self-contained build for linreal_cascade-editor-16. Base built once by scripts/build_bases.sh.
FROM kotlin-bench/linreal_cascade-editor:base

COPY check_git_changes.sh /home/
COPY prepare.sh /home/
COPY warm-compose-ui-test.patch /home/

RUN bash /home/prepare.sh
RUN chmod +x /home/*.sh

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends python3 tmux && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Seal Git history after the prepare/warm and tooling steps above so only
# the pinned base commit remains reachable (blocks fetching the upstream fix).
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/CascadeEditor
WORKDIR /home/CascadeEditor
