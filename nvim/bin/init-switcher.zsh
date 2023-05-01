#!/bin/env bash

XDG_CONFIG_HOME_PREVIEW="$HOME/Templates/nvim-configs-experimental"
ln -sf "$XDG_CONFIG_HOME_PREVIEW/LazyVim" "$HOME/.config/LazyVim"
ln -sf "$XDG_CONFIG_HOME_PREVIEW/NvChad" "$HOME/.config/NvChad"

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"

function nvim-switch() {
  items=("LazyVim" "NvChad")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing was selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# bindkey -s ^o "nvim-switch\n"
