#!/usr/bin/env bash

function install_tpm() {
  local plugins_dir="$HOME/.tmux/plugins"
  rm -rf "$plugins_dir"
  mkdir -p "$plugins_dir"
  git clone https://github.com/tmux-plugins/tpm "$plugins_dir/tpm"
  tmux source ~/.tmux.conf
  tmux run-shell ~/.tmux/plugins/tpm/bindings/install_plugins
}

install_tpm

unset install_tpm
