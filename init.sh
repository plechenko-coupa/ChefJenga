#!/usr/bin/env bash

SCRIPT_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

jenga_converge() {
  echo "Converging..."
  chef_dir="$SCRIPT_DIR/.chef"
  mkdir -p "$chef_dir"
  sudo chef-client -z --config-option log_location="$chef_dir/chef-client.log" --config-option cache_path="$chef_dir" -o jenga
  [[ -f "$chef_dir/cache/chef-stacktrace.out" ]] && sudo chmod a+r "$chef_dir/cache/chef-stacktrace.out"
}
jenga_test() {
  echo "Running tests..."
  curl http://localhost:8080/ && /opt/chef/bin/inspec exec "$SCRIPT_DIR/tests" || echo 'Failed to connect to http://localhost:8080. Nothing to check'
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
