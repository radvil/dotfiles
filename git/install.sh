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

__setup__() {
  if confirmed "Install \"Git Utilities\" ?"; then
    if ! command -v "lazygit" >/dev/null 2>&1; then
      info "Installing \"git, lazygit, git-delta...\""
      sudo pacman -S git git-delta lazygit --needed --noconfirm
      [ ! $? -eq 0 ] || warn "Installation failed! Please check the logs."
      okay "\"git, lazygit, git-delta\" installed with no errors!"
    else
      okay "\"lazygit\" has already been installed. Skipping..."
    fi
  fi

	if confirmed "Renew configuration ?"; then
    local src_dir="$DOTFILES/git"
    local target_dir="$HOME/.config/lazygit"
    [ -d "$target_dir" ] || mkdir -p "$target_dir"
    if [ -f "$src_dir/config.yml" ]; then
      cp -r "$src_dir/config.yml" "$target_dir/config.yml.bak"
      info "Backup old \"lazygit\" configuration file"
    fi
    ln -sf "$src_dir/lazygit.yml" "$target_dir/config.yml"
    okay "Configuration linked to $target_dir/config.yml"
  fi
}

__setup__
