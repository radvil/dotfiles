#!/usr/bin/env bash

source="$DOTFILES/extras/keychron/keychron.service" 
destination="/etc/systemd/system/keychron.service"
if [[ ! -f "$destination" ]]; then
  sudo ln -sf "$source" "$destination"
  sudo systemctl enable keychron.service
  okay "\"Keychron Service\" successfully setup!"
else
  info "\"Keychron Service\" has already exists. Skipping..."
fi
