#!/bin/bash

if (( $+commands[starship] )); then
  unset ZSH_THEME # ignore oh-my-zsh theme
  export STARSHIP_CONFIG="$DOTFILES/starship/config.toml"
  eval "$(starship init zsh)"
fi
