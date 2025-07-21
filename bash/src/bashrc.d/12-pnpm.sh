#!/usr/bin/env bash

# shellcheck disable=SC1090

function setup() {
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
}

setup

unset setup
