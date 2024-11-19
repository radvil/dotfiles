#!/usr/bin/env bash

# links configs
setup_link "$DOTFILES/kitty" "$HOME/.config/kitty"
setup_link "$DOTFILES/alacritty/config.toml" "$HOME/.config/alacritty.toml"
setup_link "$DOTFILES/zsh/env" "$HOME/.zshenv"
setup_link "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"

# Media players codecs
# if confirmed "Do you wanna install media packages ?"; then
# 	install_packages "$DOTFILES/build/media-packages.txt"
# 	okay "Media players and codecs installed successfully!"
# fi

# Additional web browsers
# if confirmed "Do you wanna install additional web browsers?"; then
# 	info "Installing additional web browsers..."
# 	yay -S google-chrome firefox brave-nightly-bin --needed
# 	okay "Additional web browsers installed successfully"
# fi

source_file "$DOTFILES/starship/install.sh"
source_file "$DOTFILES/tmux/install.sh"
source_file "$DOTFILES/git/install.sh"
source_file "$DOTFILES/nvim/bin/install.sh"

sudo chsh -s /usr/bin/zsh
