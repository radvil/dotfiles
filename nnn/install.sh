#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED -eq 0 ]] && source "$DOTFILES/build/utils.sh"
sudo pacman -S nnn
source_file "$DOTFILES/nnn/install-plugins.sh"
