#!/usr/bin/env zsh

if [ -z "${BUN_INSTALL}" ]; then
  BUN_INSTALL="$HOME/.bun" 
  [ -d "$BUN_INSTALL/bin" ] && PATH="$BUN_INSTALL/bin:$PATH"
  export BUN_INSTALL
fi


if ! command -v nvm &> /dev/null; then
  # HACK: prevent sourcing every time a new instance of zsh spawned
  # becaues it is too much slow
  function load_nvm() {
    [ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"
    [ -s "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"
    nvm ls
    printf "\033[2K[\033[00;32m✔ OKAY\033[0m] nvm loaded\n"
  }
fi

# if [ -z "${NVM_DIR}" ]; then
#   [ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"
#   [ -s "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"
# fi
