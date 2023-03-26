#!/usr/bin/env bash

info "Installing rofi..."
sudo pacman -S rofi --needed
okay "rofi installed successfully"
[[ -d "$HOME/.config/rofi" ]] && rm -rf "$HOME/.config/rofi"
mkdir -p "$HOME/.config/rofi"
setup_link "$DOTFILES/extras/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"
