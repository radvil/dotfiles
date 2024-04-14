#!/usr/bin/env zsh

if (( $+commands[starship] )); then
  unset ZSH_THEME # ignore oh-my-zsh theme
  export STARSHIP_CONFIG="$DOTFILES/starship/config.toml"
  eval "$(starship init zsh)"
else
  echo '[oh-my-zsh] starship not found, please install it from https://starship.rs'
fi
