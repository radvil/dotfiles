#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/build/utils.sh"

if [ -f "$HOME/.tmux" ]; then
  rm -rf "$HOME/.tmux"
fi

sudo pacman -S tmux
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
