#!/usr/bin/env bash

# This script starts up Chef Jenga:
# - Checks for the required dependencies (Git, Visual Studio Code, xxd, Docker).
# - Clones the workspace branch of the repository if it doesn't exist, or fetches updates from the remote if it does.
# - Creates a new branch for the workspace with a timestamp (ws/YYYYMMDD_HHMMSS).
# - Opens the Chef Jenga in Visual Studio Code and workspace in Dev Container

set -euo pipefail

if ! command -v git &> /dev/null; then
  echo "Error: Git is not installed or not in the system PATH."
  exit 1
fi

if ! command -v code &> /dev/null; then
  echo "Error: Visual Studio Code is not installed or not in the system PATH."
  exit 1
fi

if ! command -v xxd &> /dev/null; then
  echo "Error: xxd is not installed or not in the system PATH."
  exit 1
fi

if ! command -v docker &> /dev/null; then
  echo "Error: Docker is not installed or not in the system PATH."
  exit 1
fi

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

code --folder-uri "$uri"
