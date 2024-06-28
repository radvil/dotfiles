#!/usr/bin/env sh

function info() {
	printf "[\033[00;34mINFO\033[0m] %s$1\n"
}

function warn() {
	printf "[\033[0;33mWARN\033[0m] %s$1\n"
}

function okay() {
	printf "\033[2K[\033[00;32m✔ OK\033[0m] %s$1\n"
}

function confirmed() {
	read -r -p "[❓] $1 [Y/n] >> " answer
	answer=${answer,,} # tolower
	if [[ $answer =~ ^(y| ) ]] || [[ -z $answer ]]; then
		return 0
	else
		return 1
	fi
}

__install__() {
	name="wezterm"
	if confirmed "Install \"$name\" ?"; then
		info "Installing wezterm ..."
		sudo dnf install ${name} &&
			okay "${name} installed with no errors!"
	fi
	if confirmed "Setup configurations ?"; then
		src_path="$DOTFILES/wezterm"
		dst_path="$HOME/.config/wezterm"
		if [ -d "$dst_path" ]; then
			cp -r "$dst_path" "${dst_path}.bak"
			info "Backing up old 'wezterm' config file as ${dst_path}.bak"
		fi
		ln -sf "$src_path" "$dst_path" &&
			okay "$src_path linked to $dst_path"
	fi
}

__install__
