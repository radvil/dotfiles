#!/usr/bin/env bash

cd "$(dirname "$0")/.."

source_dir=$(pwd -P)
username=$(whoami)
DOTFILES="$source_dir"
printf "Setting up dotfiles in %s$DOTFILES...\n"
sudo chown -R "$username" "$DOTFILES"

set -e

# shellcheck source=../common/funcs.sh
source "$DOTFILES/common/funcs.sh"
ensure_deps "$DOTFILES/build/deps.txt"

chsh -s "$(which zsh)"

setup_link "$DOTFILES/tmux/tpm" "$HOME/.tmux"
setup_link "$DOTFILES/tmux/tmux.conf" "$HOME/.tmux.conf"
setup_link "$DOTFILES/kitty" "$HOME/.config/kitty"
setup_link "$DOTFILES/nvim" "$HOME/.config/nvim"
setup_link "$DOTFILES/lf" "$HOME/.config/lf"
setup_link "$DOTFILES/rofi" "$HOME/.config/rofi"
setup_link "$DOTFILES/zsh/history" "$HOME/.zsh_history"
setup_link "$DOTFILES/zsh/env" "$HOME/.zshenv"
setup_link "$DOTFILES/zsh/init.zsh" "$HOME/.zshrc"

copy_binaries "$DOTFILES/binaries"
copy_scripts "$DOTFILES/alias/scripts"

zsh
