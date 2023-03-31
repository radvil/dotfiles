#!/usr/bin/env bash

source "$DOTFILES/build/utils.sh"

# spotify terminal client
if ! has_installed spt; then
	if confirmed "Do you wanna install and setup spotify terminal client?"; then
		info "Installing spotify-tui client..."
		yay -S spotify-tui spotifyd
		okay "spotify-tui client installed successfully!"
		rm -rf "$HOME/.config/spotify-tui"
		mkdir -p "$HOME/.config/spotify-tui"
		ln -sf "$DOTFILES/extras/spotify/spotify-tui.yml" "$HOME/.config/spotify-tui/client.yml"
		[[ -d "$HOME/.config/spotifyd" ]] || mkdir -p "$HOME/.config/spotifyd"
		ln -sf "$DOTFILES/extras/spotify/spotifyd.conf" "$HOME/.config/spotifyd/spotifyd.conf"
		[[ -d "$HOME/.config/systemd" ]] || mkdir -p "$HOME/.config/systemd"
		ln -sf "$DOTFILES/extras/spotify/spotifyd.service" "$HOME/.config/systemd/spotifyd.service"
		systemctl --user enable spotifyd.service
		systemctl --user start spotifyd.service
	fi
else
	info "spotify-tui has already installed. Skipping..."
fi
