#!/bin/bash

sudo dnf install -y zsh

DOTFILES="$HOME/.dotfiles"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

rm -rf "$HOME/.oh-my-zsh" && mkdir -p "$ZSH_CUSTOM"

export CHSH="no"
export KEEP_ZSHRC="yes"
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" &&
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" &&
  git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

ZSH=$(sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)") \
  ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
