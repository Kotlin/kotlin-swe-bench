FROM europe-west4-docker.pkg.dev/gke-dev-dws-jbr/ml/kotlinai/thunderbird_thunderbird-android:persistent-pr-9716
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/thunderbird-android
COPY task-assets/instruction/ /task-assets/instruction/
WORKDIR /home/thunderbird-android
