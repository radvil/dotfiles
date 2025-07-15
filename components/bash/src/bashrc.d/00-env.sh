#!/usr/bin/env bash

src_dir="$(dirname "${BASH_SOURCE[0]}")/../../../core/src"
env_file=$(realpath "$src_dir/env/global.env")

if [ -f "$env_file" ]; then
  while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" =~ ^# ]] && continue
    if [ "$key" = "PATH_EXTRA" ]; then
      read -ra PATH_EXTRA_ARR <<<"$value"
    else
      eval "export $key=\"$value\""
    fi
  done <"$env_file"
fi

# Append valid paths
if [ "${#PATH_EXTRA_ARR[@]}" -gt 0 ]; then
  for dir in "${PATH_EXTRA_ARR[@]}"; do
    eval dir="$dir"
    [ -d "$dir" ] && PATH="$dir:$PATH"
  done
  export PATH
fi
