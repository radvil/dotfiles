#!/usr/bin/env bash

function setup() {
  local installer
  installer=$(realpath "components/plasma/scripts/plasma-tools.sh")
  chmod +x "$installer"
  bash -c "$installer --restore-all"
}

setup

unset setup
