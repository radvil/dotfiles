#!/usr/bin/env bash

function install_core_packages() {
  sudo dnf copr enable alternateved/eza -y
  sudo dnf install -y git curl cargo eza

  # nvm install
  export NVM_DIR="$HOME/.config/nvm"
  [ -d "$NVM_DIR" ] || mkdir -p "$NVM_DIR"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
}

install_core_packages

unset install_core_packages
