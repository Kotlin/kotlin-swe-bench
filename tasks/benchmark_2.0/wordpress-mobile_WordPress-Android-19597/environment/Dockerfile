FROM ghcr.io/jetbrains/kotlin-swe-bench-2/wordpress-mobile_wordpress-android:persistent-pr-19597
RUN apt-get update -qq && apt-get install -y --no-install-recommends tmux python3 && pip install --quiet asciinema || true
COPY seal_git_history.sh /tmp/seal_git_history.sh
RUN bash /tmp/seal_git_history.sh /home/WordPress-Android
WORKDIR /home/WordPress-Android
