#!/usr/bin/env sh

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/build/utils.sh"
yay -S neovim-nightly-bin
source "$DOTFILES/nvim/bin/setup-links.sh"
