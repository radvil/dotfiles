#!/usr/bin/env bash

set -e

font_packages="$DOTFILES/extras/fonts/packages.txt"
info "Selecting $(cat "$font_packages") to be installed!"
info "Installing additional fonts..."
install_packages "$font_packages"
okay "Extra fonts installed successfully!"

if confirmed "Do you wanna install and setup the emoji fonts?"; then
  info "Setting up Noto Emoji font..."
  sudo pacman -S noto-fonts-emoji --needed
  echo '<?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
  <alias>
  <family>sans-serif</family>
  <prefer>
  <family>Noto Sans</family>
  <family>Noto Color Emoji</family>
  <family>Noto Emoji</family>
  <family>DejaVu Sans</family>
  </prefer> 
  </alias>

  <alias>
  <family>serif</family>
  <prefer>
  <family>Noto Serif</family>
  <family>Noto Color Emoji</family>
  <family>Noto Emoji</family>
  <family>DejaVu Serif</family>
  </prefer>
  </alias>

  <alias>
  <family>monospace</family>
  <prefer>
  <family>Noto Mono</family>
  <family>Noto Color Emoji</family>
  <family>Noto Emoji</family>
  <family>DejaVu Sans Mono</family>
  </prefer>
  </alias>
  </fontconfig>
  ' | sudo tee -a /etc/fonts/local.conf > /dev/null

# reload font cache
fc-cache

okay "Noto Emoji Font installed successfully"
warn "It is recommended to restart applications that are currenly opened!"
fi
