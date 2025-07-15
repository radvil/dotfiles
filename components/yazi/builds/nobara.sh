#!/usr/bin/env bash

function __info() {
  printf "\e[34m[INFO]\e[0m %s\n" "$1"
}

function __success() {
  printf "\e[32m[SUCCESS]\e[0m %s\n" "$1"
}

function __install_yazi() {
  local app_name="yazi"
  local url="https://github.com/sxyazi/$app_name/releases/download/v25.2.26/yazi-aarch64-unknown-linux-musl.zip"
  local archive="$HOME/Downloads/yazi.zip"
  local install_dir="$HOME/.local/bin"
  local extracted_dir="$install_dir/$app_name-aarch64-unknown-linux-musl"

  __info "Installing $app_name (terminal based file manager) ..."

  if command -v $app_name &>/dev/null; then
    __info "$app_name already installed. Skipping..."
    return 0
  fi

  sudo mkdir -p "$install_dir"
  sudo curl -L "$url" -o "$archive"
  sudo unzip -o "$archive" -d "$install_dir"
  sudo ln -sf "$extracted_dir/$app_name" "$install_dir/$app_name"
  sudo rm "$archive"
  sudo chmod +x "$install_dir/$app_name"
  __success "$app_name installed successfully."
}

__install_yazi

unset __info
unset __success
unset __install_yazi
