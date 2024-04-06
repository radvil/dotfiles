#!/usr/bin/env sh

__install__() {
	source_dir="$DOTFILES/nvim/configs"
	target_dir="$HOME/.config"
	ln -sf "$source_dir/nvmini" "$target_dir/nvim"
	ln -sf "$source_dir/nvmini" "$target_dir/nvmini"
	ln -sf "$source_dir/lazyvim" "$target_dir/lazyvim"
}

__install__
