#!/usr/bin/env bash

function setup() {
  local installer
  installer=$(realpath "components/flatpak/builds/fedora.sh")
  chmod +x "$installer"
  bash -c "$installer"
}

setup

unset setup
