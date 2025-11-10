#!/usr/bin/env bash

function setup() {
  local installer
  installer=$(dirname "$0")/install-fonts.sh
  chmod +x "$installer"
  bash -c "$installer"
}

setup

unset setup
