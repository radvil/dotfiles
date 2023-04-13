#!/usr/bin/env bash

[[ ! -d $DOTFILES ]] && DOTFILES="$HOME/.dotfiles"
[[ ! -f "$DOTFILES/ssh/init.sh" ]] || source "$DOTFILES/ssh/init.sh"

