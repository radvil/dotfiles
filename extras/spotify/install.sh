#!/usr/bin/env bash
# shellcheck disable=SC2181

[[ $DOTFILES_UTILS_LOADED -eq 0 ]] && source "$DOTFILES/build/utils.sh"

function __install_spotify-tui() {
	# if command not found "spt
	if has_installed spt; then
		info "spotify-tui has already installed. Skipping..."
	else
		info "Installing spotify-tui..."
		yay -S spotify-tui
		okay "spotify-tui client installed successfully!"
		local config_dir="$HOME/.config/spotify-tui"
		[[ -d "$config_dir" ]] || mkdir -p "$config_dir"
		ln -sf "$DOTFILES/extras/spotify/spotify-tui.yml" "$config_dir/client.yml"
	fi
}

# install spotify daemon
if has_installed spotifyd; then
	info "spotifyd has already installed. Skipping..."
else
	info "Installing spotifyd..."
	sudo pacman -S spotifyd
	if [[ $? -eq 0 ]]; then
		info "spotifyd installed successfully!"
		config_dir="$HOME/.config/spotifyd"
		[[ -d "$config_dir" ]] || mkdir -p "$config_dir"
		ln -sf "$DOTFILES/extras/spotify/spotifyd.conf" "$config_dir/spotifyd.conf"
		__install_spotify-tui
	fi
fi
