#!/usr/bin/env bash

# shellcheck disable=SC1091

function setup() {
  local nvm_dir="$HOME/.config/nvm"
  [ -z "$nvm_dir" ] && printf "\e[34m[INFO]\e[0m %s\n" "$1"
  [ -s "$nvm_dir/nvm.sh" ] && \. "$nvm_dir/nvm.sh"
  [ -s "$nvm_dir/bash_completion" ] && \. "$nvm_dir/bash_completion"
  export NVM_DIR="$nvm_dir"
}

setup "$@"

unset setup
