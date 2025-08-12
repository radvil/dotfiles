#!/usr/bin/env bash

function setup() {
  local installer
  installer=$(dirname "$0")/install-apps.sh
  chmod +x "$installer"
  bash -c "$installer"
  paru -S obs-vkcapture --noconfirm
}

setup

unset setup
