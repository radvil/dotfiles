#!/usr/bin/env zsh

plug_dir="$DOTFILES/zsh/plug"

[ -s "$plug_dir/git.zsh" ] && source "$plug_dir/git.zsh"
[ -s "$plug_dir/vi-mode.zsh" ] && source "$plug_dir/vi-mode.zsh"
