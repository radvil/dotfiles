#!/usr/bin/env zsh

function __setup_nvm() {
  [ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"
  [ -s "$HOME/.nvm/bash_completion" ] && source "$HOME/.nvm/bash_completion"
}

# NOTE: Load on first shell initialization
if [ -z "${NVM_DIR}" ]; then
  __setup_nvm
else
  if ! command -v nvm &> /dev/null; then
    # HACK: prevent sourcing every time a new instance of zsh spawned
    # becaues it is too much slow, so better expose it as a function
    function dot-load-nvm() {
      __setup_nvm
      nvm ls
      printf "\033[2K[\033[00;32m✔ OKAY\033[0m] nvm loaded\n"
    }
  fi
fi

