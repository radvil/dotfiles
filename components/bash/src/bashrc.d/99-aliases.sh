#!/usr/bin/env bash

aliases_basedir="$DOTFILES/components/core/src/aliases"
shared_aliases="$aliases_basedir/shared.aliases"
bash_aliases="$aliases_basedir/bash.aliases"

if [ -f "$shared_aliases" ]; then
  while IFS='=' read -r key value; do
    # skip empty lines or comments
    [[ -z "$key" || "$key" =~ ^# ]] && continue

    # shellcheck disable=SC2139
    alias "$key"="$value"
  done <"$shared_aliases"
fi

if [ -f "$bash_aliases" ]; then
  # shellcheck disable=SC1090
  source "$bash_aliases"
fi
