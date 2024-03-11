#!/usr/bin/env bash

if [ $DOTFILES_UTILS_LOADED != "true" ]; then
  source "$DOTFILES/build/utils.sh"
fi

if [ -d "$HOME/.tmux/plugins" ]; then
  rm -rf "$HOME/.tmux/plugins"
fi

sudo pacman -S tmux
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
## tmux source ~/.tmux.conf
