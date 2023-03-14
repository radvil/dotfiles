#!/usr/bin/env bash
# shellcheck disable=SC2046,2086,SC2181

cd "$(dirname "$0")/.."

pwd=$(pwd -P)

DOTFILES="$pwd"

set -e

ensure_deps() {
	local deps="$DOTFILES/common/deps.txt"
	info "installing common dependencies.."
	sudo apt install $(cat $deps) -y
	if [[ ! $? -eq 0 ]]; then
		warn "failed during dependencies installation!"
	else
		okay "dependencies installed successfully!"
	fi
}

# shellcheck source=../common/funcs.sh
source "$DOTFILES/common/funcs.sh"

setup_link "$DOTFILES/tmux/tpm"       "$HOME/.tmux"
setup_link "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
setup_link "$DOTFILES/kitty"          "$HOME/.config/kitty"
setup_link "$DOTFILES/nvim"           "$HOME/.config/nvim"
setup_link "$DOTFILES/zsh/history"    "$HOME/.zsh_history"
setup_link "$DOTFILES/zsh/env"        "$HOME/.zshenv"
setup_link "$DOTFILES/zsh/init.zsh"   "$HOME/.zshrc"

ensure_deps
