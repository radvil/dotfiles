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
  if confirmed "Install \"Git Utilities\" ?"; then
    local pkgs="git git-delta lazygit bat"
    info "Installing $pkgs ..."
    sudo pacman -S ${pkgs} --needed --noconfirm && \
    okay "$pkgs installed with no errors!"
  fi

	if confirmed "Setup configurations ?"; then
    local src_dir="$DOTFILES/git"

    # Link .gitconfig
    if [ -f "$HOME/.gitconfig" ]; then
      cp -r "$HOME/.gitconfig" "$HOME/.gitconfig.old"
      info "Backing up old '.gitconfig' file to $HOME/.gitconfig"
    fi
    ln -sf "$src_dir/gitconfig" "$HOME/.gitconfig" && \
      okay "$src_dir/gitconfig linked to $HOME/.gitconfig"

    # Link bat.conf
    if [ ! -d "$HOME/.config/bat" ]; then
      mkdir -p "$HOME/.config/bat";
      info "Creating $HOME/.config/bat"
    fi
    if [ -f "$HOME/.config/bat/config" ]; then
      cp -r "$HOME/.config/bat/config" "$HOME/.config/bat/config.old"
      info "Backing up old 'config' file to $HOME/.config/bat/config.old"
    fi
    ln -sf "$src_dir/bat.conf" "$HOME/.config/bat/config" && \
      okay "$src_dir/bat.conf linked to $HOME/.config/bat/config"

    # Link Lazygit
    local lazy_dir="$HOME/.config/lazygit"
    [ -d "$lazy_dir" ] || mkdir -p "$lazy_dir"
    if [ -f "$lazy_dir/config.yml" ]; then
      cp -r "$lazy_dir/config.yml" "$lazy_dir/config.yml.old"
      info "Backing up old 'lazygit.yml' file to $lazy_dir/config.yml.old"
    fi
    ln -sf "$src_dir/lazygit.yml" "$lazy_dir/config.yml" && \
      okay "$src_dir/lazygit.yml linked to $lazy_dir/config.yml"
  fi
}

__install__
