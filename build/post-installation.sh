#!/usr/bin/env bash

# links configs
setup_link "$DOTFILES/kitty" "$HOME/.config/kitty"
setup_link "$DOTFILES/alacritty/config.toml" "$HOME/.config/alacritty.toml"
setup_link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

source_file "$DOTFILES/zsh/install.sh"
source_file "$DOTFILES/starship/install.sh"
source_file "$DOTFILES/tmux/install.sh"
source_file "$DOTFILES/git/install.sh"
source_file "$DOTFILES/nvim/bin/install.sh"

sudo chsh -s /usr/bin/zsh
