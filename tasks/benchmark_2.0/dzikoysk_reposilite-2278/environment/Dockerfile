FROM europe-west4-docker.pkg.dev/gke-dev-dws-jbr/ml/kotlinai/dzikoysk_reposilite:persistent-pr-2278
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/reposilite
WORKDIR /home/reposilite
