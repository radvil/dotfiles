#!/usr/bin/env bash
# shellcheck disable=SC2046,2086,SC2181

cd "$(dirname "$0")/.."

pwd=$(pwd -P)

RADVIL="$pwd"

set -e

ensure_deps() {
	local deps="$RADVIL/common/deps.txt"
	info "installing common dependencies.."
	sudo apt install $(cat $deps) -y
	if [[ ! $? -eq 0 ]]; then
		warn "failed during dependencies installation!"
	else
		okay "dependencies installed successfully!"
	fi
}

# shellcheck source=../common/funcs.sh
source "$RADVIL/common/funcs.sh"

setup_link "$RADVIL/tmux/tpm"       "$HOME/.tmux"
setup_link "$RADVIL/tmux/tmux.conf" "$HOME/.tmux.conf"
setup_link "$RADVIL/kitty"          "$HOME/.config/kitty"
setup_link "$RADVIL/nvim"           "$HOME/.config/nvim"
setup_link "$RADVIL/zsh/history"    "$HOME/.zsh_history"
setup_link "$RADVIL/zsh/env"        "$HOME/.zshenv"
setup_link "$RADVIL/zsh/init.zsh"   "$HOME/.zshrc"

ensure_deps
