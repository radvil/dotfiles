#!/usr/bin/env zsh

if [ -z "${BUN_INSTALL}" ]; then
  BUN_INSTALL="$HOME/.bun" 
  [ -d "$BUN_INSTALL/bin" ] && PATH="$BUN_INSTALL/bin:$PATH"
  export BUN_INSTALL
fi

if [ -z "${NVM_DIR}" ]; then
  [ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"
  [ -s "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"
fi
