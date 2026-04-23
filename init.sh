#!/usr/bin/env bash

export GEM_HOME="$HOME/.gem"
export PATH="$GEM_HOME/bin:/opt/chef/bin:$PATH"
export CHEF_LICENSE=accept

jenga_converge() {
  echo "Converging..."
  sudo chef-client -z -c .chef/config.rb -o "recipe[jenga::default]"
}
jenga_test() {
  echo "Running tests..."
  curl http://localhost:8080/ && sudo /opt/chef/bin/inspec exec tests || echo 'Failed to connect to http://localhost:8080. Nothing to check'
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

[[ -f "$HOME/.bash_aliases" ]] || (echo "source '${BASH_SOURCE[0]}'" >>~/.bash_aliases)
