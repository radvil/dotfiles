#!/bin/env bash

## TODO: create loop
ln -sf "$DOTFILES/nvim/previews/LazyVim" "$HOME/.config/LazyVim"
alias vim="NVIM_APPNAME=LazyVim nvim"

function nvim-switch() {
  items=("Default LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing was selected"
    return 0
  elif [[ $config == "Default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# bindkey -s ^o "nvim-switch\n"
