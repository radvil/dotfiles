#!/usr/bin/env bash

function setup() {
  if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
    # ALT+M to call zmux
    bind '"\em": "zmux\n"'
  fi
}

setup

unset setup
