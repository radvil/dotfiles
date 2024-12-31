#!/usr/bin/env bash

# INSTALL ESSENTIALS PACKAGES
install_packages "$DOTFILES/build/essential-packages.txt" &&
  source_file "$DOTFILES/ssh/install.sh"
