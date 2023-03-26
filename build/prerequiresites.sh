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

# CUSTOM SETUPS

## Node Version Manager
if confirmed "Do you wanna install & setup \"Node Version Manager\" ?"; then
	source_file "$DOTFILES/extras/nvm/install.sh"
fi

## Oh My Zsh
if confirmed "Do you wanna install & setup \"Oh My Zsh\" ?"; then
	source_file "$DOTFILES/omz/install.sh"
fi
