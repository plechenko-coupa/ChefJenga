#!/usr/bin/env bash

JENGA_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

jenga_converge() {
  echo "Converging..."
  chef_dir="$JENGA_DIR/.chef"
  mkdir -p "$chef_dir"
  log_file="$chef_dir/chef-client-$(date +%Y%m%d%H%M%S).log"
  st_file="$chef_dir/cache/chef-stacktrace.out"
  sudo rm -f "$st_file"
  sudo chef-client -z --config-option cache_path="$chef_dir" -o jenga | tee "$log_file"
  echo "Log file: '$log_file'" >&2
  [[ -f "$chef_dir/cache/chef-stacktrace.out" ]] && sudo chmod a+r "$chef_dir/cache/chef-stacktrace.out"
}

jenga_lint() {
  (
    cd "$JENGA_DIR" || exit
    echo 'Running Linter...'
    bundle exec cookstyle -c .cookstyle.yml --format simple .
  )
}

jenga_test() {
  (
    cd "$JENGA_DIR" || exit
    echo "Running tests..."
    curl http://localhost:8080/ && /opt/chef/bin/inspec exec tests || echo 'Failed to connect to http://localhost:8080. Nothing to check'
  )
}

jenga_commit() {
  commit_message="$1"
  while [[ -z "$commit_message" ]]; do
    read -rp "Enter a commit message: " commit_message
  done
  echo "Committing changes..."
  git add .
  git commit -m "Jenga turn: $commit_message"
}

if [[ ! -f "$HOME/.bash_aliases" ]]; then
  # It is unlikely that ~/.bash_aliases exists in the Dev Container,
  # so we are assuming that it is a fresh environment
  echo 'Setting up the environment for Chef Jenga...' >&2
  echo "source '${BASH_SOURCE[0]}'" >>"$HOME/.bash_aliases"
  echo "Installing dependencies into $GEM_HOME..." >&2
  bundle install --prefer-local
fi
