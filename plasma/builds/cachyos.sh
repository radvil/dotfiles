#!/usr/bin/env bash

function setup() {
  local installer
  installer=$(dirname "$0")/nobara.sh
  chmod +x "$installer"
  bash -c "$installer"
}

setup

unset setup
