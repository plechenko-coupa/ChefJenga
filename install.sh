#!/usr/bin/env bash

ws_dir=workspace
git_url="$(git remote get-url origin)"
if [[ -d "$ws_dir" ]]; then
  echo "Directory '$ws_dir' already exists. Please remove it before running this script."
  exit 1
fi
git clone "$git_url" --depth 1 --branch workspace "$ws_dir"
git -C "$ws_dir" checkout -B "workspaces/$(date +%Y%m%d_%H%M%S)" workspace
