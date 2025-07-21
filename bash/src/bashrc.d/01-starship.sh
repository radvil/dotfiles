#!/usr/bin/env bash

STARSHIP_CONFIG=""

function setup() {
  if command -v starship &>/dev/null; then
    if [ -z "${DISTROBOX_ENTER_PATH+x}" ] && [ -f "$STARSHIP_CONFIG" ]; then
      eval "$(starship init bash)"
    fi
  fi

  if [ -n "$DISTROBOX_ENTER_PATH" ]; then
    if command -v fastfetch &>/dev/null; then
      fastfetch
    fi
  fi
}

setup

unset setup
