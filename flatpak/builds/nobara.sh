#!/usr/bin/env bash

function setup() {
  local installer
  installer=$(dirname "$0")/fedora.sh
  chmod +x "$installer"
  bash -c "$installer"
}

setup

unset setup
