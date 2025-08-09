#!/usr/bin/env bash

function setup() {
  local installer
  installer="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../scripts/plasma-tools.sh"
  chmod +x "$installer"
  bash -c "$installer --restore-all"
}

setup

unset setup
