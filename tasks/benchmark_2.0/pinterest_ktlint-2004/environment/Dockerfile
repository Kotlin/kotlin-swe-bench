FROM europe-west4-docker.pkg.dev/gke-dev-dws-jbr/ml/kotlinai/pinterest_ktlint:persistent-pr-2004
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/ktlint
WORKDIR /home/ktlint
