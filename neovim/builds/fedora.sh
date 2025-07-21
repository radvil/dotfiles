#!/usr/bin/env bash

function install_neovim() {
  sudo dnf copr enable foopsss/shell-color-scripts -y &&
    sudo dnf copr enable agriffis/neovim-nightly -y &&
    sudo dnf install git ripgrep fd-find gcc hub neovim python3-neovim shell-color-scripts -y,
}

install_neovim

unset install_neovim
