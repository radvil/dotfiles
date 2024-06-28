#!/usr/bin/env sh

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/build/utils.sh"
sudo dnf install neovim
source "$DOTFILES/nvim/bin/setup-links.sh"
