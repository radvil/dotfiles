#!/usr/bin/env bash
# changing dir on lazygit exited
# @TLDR change repos in lazygit and automatically change directory on exit

# shellcheck source=/dev/null
source "$HOME/.radvil/_utils.sh"

ensure_installed lazygit || warn "lazygit was not installed"
newdir="$HOME/lazygit/newdir"
lazygit "$@"
if [ -f "$newdir" ]; then
	"cd $(cat "$newdir")" || exit
	rm -f "$newdir >/dev/null"
fi
