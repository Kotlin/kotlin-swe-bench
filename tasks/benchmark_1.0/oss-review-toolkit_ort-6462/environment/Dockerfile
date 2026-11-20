# Self-contained build for oss-review-toolkit_ort-6462. Base built once by scripts/build_bases.sh.
FROM kotlin-bench/oss-review-toolkit_ort:base

COPY exclude-flaky-tests.gradle /home/
COPY check_git_changes.sh /home/
COPY prepare.sh /home/

RUN bash /home/prepare.sh
RUN chmod +x /home/*.sh

RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
# Seal Git history after the prepare/warm and tooling steps above so only
# the pinned base commit remains reachable (blocks fetching the upstream fix).
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/ort
WORKDIR /home/ort
