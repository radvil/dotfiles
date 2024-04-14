#!/usr/bin/env zsh

if [ -z "${__DOT_OMZ}" ]; then
  __DOT_OMZ="$HOME/.oh-my-zsh/oh-my-zsh.sh"
  if [ -s "$__DOT_OMZ" ]; then
    export __DOT_OMZ
  fi
fi

plugins=(vi-mode fancy-ctrl-z)
source "$__DOT_OMZ"
