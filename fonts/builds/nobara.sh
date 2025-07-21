#!/usr/bin/env bash

function log() {
  printf "[LOG] %s\n" "$1"
}

function info() {
  printf "\e[34m[INFO]\e[0m %s\n" "$1"
}

function success() {
  printf "\e[32m[SUCCESS]\e[0m %s\n" "$1"
}

function error() {
  printf "\e[31m[ERROR]\e[0m %s\n" "$1" >&2
}

function __install_nerd_font() {
  local font_name="$1"
  local font_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font_name}.tar.xz"
  local download_dir="$HOME/Downloads/Compressed"
  local extract_dir="$download_dir/$font_name"
  local font_dest="$HOME/.local/share/fonts"
  local archive_file="${font_name}.tar.xz"

  info "Installing nerd font ($font_name)..."

  if [ -d "$font_dest/$font_name" ]; then
    info "$font_name already installed. Skipping..."
    return 0
  fi

  for cmd in curl tar fc-cache; do
    command -v "$cmd" >/dev/null 2>&1 || {
      error "Missing command: $cmd"
      return 1
    }
  done

  mkdir -p "$extract_dir" "$font_dest"

  if ! curl -fLo "$archive_file" "$font_url"; then
    error "Failed to download $font_name.tar.xz"
    return 1
  fi

  if ! tar -xf "$archive_file" -C "$extract_dir"; then
    error "Failed to extract $font_name.tar.xz"
    return 1
  fi

  if [ ! -d "$extract_dir" ] || [ -z "$(ls -A "$extract_dir")" ]; then
    error "Extraction failed. No files found in $extract_dir"
    return 1
  fi

  if mv "$extract_dir" "$font_dest/$font_name" 2>/dev/null; then
    log "Refreshing the font cache...'"
    fc-cache -fv
    log "Cleaning up downloaded font files"
    rm -rf "$archive_file"
    success "$font_name installed successfully."
  else
    error "Failed to install $font_name fonts to $font_dest"
    return 1
  fi
}

__install_nerd_font "JetBrainsMono"
__install_nerd_font "Hack"

# TODO: Install Adwaita font and set default.

unset _log
unset _info
unset _error
unset _success
unset __install_nerd_font
