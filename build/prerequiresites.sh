#!/usr/bin/env bash

# INSTALL ESSENTIALS PACKAGES
if confirmed "Do you wanna install essential packages ?"; then
  install_packages "$DOTFILES/build/essential-packages.txt"
  okay "Essential packages installed successfully!"
fi

# INSTALL MEDIA PLAYER & CODECS
if confirmed "Do you wanna install media packages ?"; then
  install_packages "$DOTFILES/build/media-packages.txt"
  okay "Media players and codecs installed successfully!"
fi

## Oh My Zsh
if confirmed "Do you wanna install & setup \"Open SSH\" ?"; then
	source_file "$DOTFILES/ssh/install.sh"
fi

## Node Version Manager
if confirmed "Do you wanna install & setup \"Node Version Manager\" ?"; then
	source_file "$DOTFILES/extras/nvm/install.sh"
fi

## Oh My Zsh
if confirmed "Do you wanna install & setup \"Oh My Zsh\" ?"; then
	source_file "$DOTFILES/omz/install.sh"
fi

## Tmux
if confirmed "Do you wanna install & setup \"Tmux\" ?"; then
	source_file "$DOTFILES/tmux/install.sh"
fi

## YAY
if confirmed "Do you wanna install & setup \"Yay\" ?"; then
	sudo pacman -S --needed git base-devel
	mkdir ~/Downloads/Programs -p
	if [ -d "$HOME/Downloads/Programs/yay" ]; then
	  rm -rf "$HOME/Downloads/Programs/yay"
	fi
	git clone https://aur.archlinux.org/yay.git ~/Downloads/Programs/yay
	pushd ~/Downloads/Programs/yay
	makepkg -si
	popd
fi

## NeoVim Nightly
if confirmed "Do you wanna install & setup \"Neovim Nightly\" ?"; then
	source_file "$DOTFILES/nvim/bin/install.sh"
fi
