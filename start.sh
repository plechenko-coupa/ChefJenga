#!/usr/bin/env bash

set -euo pipefail

script_dir="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

ws_dir="$script_dir/workspace"

if [[ -d "$ws_dir" ]]; then
  if [[ -r "$ws_dir/.git" ]]; then
    git -C "$ws_dir" fetch origin workspace
  else
    echo "Warning: $ws_dir exists but is not a git repository. Please remove it manually using the command \"rm -rf '$ws_dir'\" and then rerun this script."
    exit 1
  fi
else
  git_url="$(git remote get-url origin)"
  git clone "$git_url" --depth 1 --branch workspace "$ws_dir"
fi
ws_branch="ws/$(date -u +%Y%m%d_%H%M%S)"
git -C "$script_dir/workspace" checkout -B "$ws_branch" workspace

ws_host_path="$script_dir"
command -v wslpath &> /dev/null && ws_host_path="$(wslpath -a -w "$ws_host_path")"

json="{\"hostPath\":\"${ws_host_path//\\/\\\\}\"}"
hex=$(printf '%s' "$json" | xxd -p | tr -d '\n')
uri="vscode-remote://dev-container+${hex}/workspace"

code "$script_dir"
code --folder-uri "$uri" --new-window
