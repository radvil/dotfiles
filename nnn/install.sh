#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED != "true" ]] && source "$DOTFILES/build/utils.sh"
sudo dnf installnnn
source_file "$DOTFILES/nnn/install-plugins.sh"
