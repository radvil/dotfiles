#!/usr/bin/env bash

function install_core_packages() {
  sudo dnf install -y git curl cargo eza fish

  # nvm install
  if [ "$SHELL" == "fish" ]; then
    fish -c '
      curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
      fisher install jorgebucaran/fisher
      fisher install jorgebucaran/nvm.fish
    '
  else
    export NVM_DIR="$HOME/.config/nvm"
    [ -d "$NVM_DIR" ] || mkdir -p "$NVM_DIR"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.41.0/install.sh | bash
  fi
}

install_core_packages

unset install_core_packages
