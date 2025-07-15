#!/usr/bin/env bash

function setup() {
  local installer
  installer=$(realpath "components/neovim/builds/fedora.sh")
  chmod +x "$installer"
  bash -c "$installer"
}

setup

unset install_neovim
