#!/usr/bin/env zsh

plug_dir="$DOTFILES/zsh/plug"

[ -s "$plug_dir/git.zsh" ] && source "$plug_dir/git.zsh"
[ -s "$plug_dir/ssh.zsh" ] && source "$plug_dir/ssh.zsh"
[ -s "$plug_dir/extract.zsh" ] && source "$plug_dir/extract.zsh"
[ -s "$plug_dir/vi-mode.zsh" ] && source "$plug_dir/vi-mode.zsh"
[ -s "$plug_dir/qr-code.zsh" ] && source "$plug_dir/qr-code.zsh"
[ -s "$plug_dir/torrent.zsh" ] && source "$plug_dir/torrent.zsh"
[ -s "$plug_dir/continue-suspended-job.zsh" ] && source "$plug_dir/continue-suspended-job.zsh"

unset plug_dir
