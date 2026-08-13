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

WORKDIR /home/CascadeEditor
