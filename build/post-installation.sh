#!/usr/bin/env bash

# links configs
setup_link "$DOTFILES/git/lazygit" "$HOME/.config/lazygit"
setup_link "$DOTFILES/kitty" "$HOME/.config/kitty"
setup_link "$DOTFILES/alacritty/config.toml" "$HOME/.config/alacritty.toml"
setup_link "$DOTFILES/zsh/env" "$HOME/.zshenv"
setup_link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

# toggle color options into pacman
sudo sed -i 's/#Color/Color/g' /etc/pacman.conf

# cleanning up pacman cache every week if necessary
sudo systemctl enable paccache.timer

# Install GUI Package Manager
if ! has_installed pamac; then
	if confirmed "Install \"pamac-aur\" as GUI package manager?"; then
		info "Installing \"pamac-aur\" as GUI package manager"
		yay -S pamac-aur
		okay "\"pamac-aur\" installed successfully!"
	fi
else
	info "\"pamac-aur\" has already installed. Skipping..."
fi

# Media players codecs
if confirmed "Do you wanna install media packages ?"; then
  install_packages "$DOTFILES/build/media-packages.txt"
  okay "Media players and codecs installed successfully!"
fi

# Additional fonts and emoji
if confirmed "Do you wanna install extra fonts plus emoji support?"; then
	source_file "$DOTFILES/extras/fonts/install.sh"
fi

# Additional web browsers
if confirmed "Do you wanna install additional web browsers?"; then
	info "Installing additional web browsers..."
	yay -S google-chrome firefox brave-nightly-bin --needed
	okay "Additional web browsers installed successfully"
fi

# Enable bluetooth service
if confirmed "Do you wanna enable \"Bluetooth Service\"?"; then
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service
fi

## Tmux
if confirmed "Do you wanna install & setup \"Tmux\" ?"; then
	source_file "$DOTFILES/tmux/install.sh"
fi

## NeoVim Nightly
if confirmed "Do you wanna install & setup \"Neovim Nightly\" ?"; then
	source_file "$DOTFILES/nvim/bin/install.sh"
fi

# change default shell to zsh
sudo chsh -s /usr/bin/zsh
info "zsh has been set as the default shell"
