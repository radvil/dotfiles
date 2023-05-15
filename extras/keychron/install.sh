#!/usr/bin/env bash

# if $DOTFILES_UTILS_LOADED=0 then load utils.sh
[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/build/utils.sh"

source="$DOTFILES/extras/keychron/keychron.service" 
destination="/etc/systemd/system/keychron.service"
if [[ ! -f "$destination" ]]; then
  sudo ln -sf "$source" "$destination"
  sudo systemctl --user enable keychron.service
  okay "\"Keychron Service\" successfully setup!"
else
  info "\"Keychron Service\" has already exists. Skipping..."
fi
