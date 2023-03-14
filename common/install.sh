#!/usr/bin/env bash

cd "$(dirname "$0")/.."

pwd=$(pwd -P)
username=$(whoami)

DOTFILES="$pwd"

sudo chown -R "$username" "$DOTFILES"
ls -l "$DOTFILES"

set -e

# shellcheck source=../common/funcs.sh
source "$DOTFILES/common/funcs.sh"

setup_link "$DOTFILES/tmux/tpm" "$HOME/.tmux"
setup_link "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
setup_link "$DOTFILES/kitty" "$HOME/.config/kitty"
setup_link "$DOTFILES/nvim" "$HOME/.config/nvim"
setup_link "$DOTFILES/lf" "$HOME/.config/lf"
setup_link "$DOTFILES/rofi" "$HOME/.config/rofi"
setup_link "$DOTFILES/zsh/history" "$HOME/.zsh_history"
setup_link "$DOTFILES/zsh/env" "$HOME/.zshenv"
setup_link "$DOTFILES/zsh/init.zsh" "$HOME/.zshrc"

ensure_deps "$DOTFILES/common/deps.txt"
copy_binaries "$DOTFILES/binaries"
copy_scripts "$DOTFILES/alias/scripts"
