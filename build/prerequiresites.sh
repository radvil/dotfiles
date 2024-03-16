#!/usr/bin/env bash

# INSTALL ESSENTIALS PACKAGES
install_packages "$DOTFILES/build/essential-packages.txt"

# Install AUR Helper
if ! has_installed yay; then
  info "Installing \"yay\" as \"AUR Helper\" alternative"
  DOWNLOAD_PATH="$HOME/Downloads/Programs"
  mkdir "$DOWNLOAD_PATH" -p
  git clone https://aur.archlinux.org/yay.git "$DOWNLOAD_PATH/yay"
  pushd "$DOWNLOAD_PATH/yay" || exit
  makepkg -si
  popd || exit
  rm -rf "$DOWNLOAD_PATH/yay"
  okay "\"yay\" installed successfully!"
else
	info "\"yay\" has already installed. Skipping..."
fi

if confirmed "Do you wanna install & setup \"Open SSH\" ?"; then
	source_file "$DOTFILES/ssh/install.sh"
fi

## Oh My Zsh
if confirmed "Do you wanna install & setup \"Oh My Zsh\" ?"; then
	source_file "$DOTFILES/omz/install.sh"
fi

## Node Version Manager
if confirmed "Do you wanna install & setup \"Node Version Manager\" ?"; then
	source_file "$DOTFILES/extras/nvm/install.sh"
fi
