#!/usr/bin/env bash

function __install_spoof_dpi() {
  __info() {
    printf "\e[34m[INFO]\e[0m %s\n" "$1"
  }

  __success() {
    printf "\e[32m[SUCCESS]\e[0m %s\n" "$1"
  }

  local app_name="spoofdpi"

  if command -v $app_name &>/dev/null; then
    __info "$app_name already installed. Skipping..."
  else
    __info "Installing spoofdpi..." &&
      curl -fsSL https://raw.githubusercontent.com/xvzc/SpoofDPI/main/install.sh | bash -s linux-amd64 &&
      __success "$app_name installed successfully."
  fi

  systemctl --user daemon-reload &&
    systemctl --user enable $app_name --now &&
    systemctl --user status $app_name
}

__install_spoof_dpi

unset __install_spoof_dpi
