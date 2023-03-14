#!/usr/bin/env bash

# shellcheck source=/dev/null
source "$HOME/.radvil/_utils.sh"

cleanup() {
	exec 3>&-
	rm "$FIFO_UEBERZUG"
}
ensure_installed lf || error "lf was not installed"
ensure_installed ueberzug || error "ueberzug was not installed"
set -e
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
	lf "$@"
else
	[ ! -d "$HOME/.cache/lf" ] && mkdir --parents "$HOME/.cache/lf"
	export FIFO_UEBERZUG="$HOME/.cache/lf/ueberzug-$$"
	mkfifo "$FIFO_UEBERZUG"
	ueberzug layer -s -p json <"$FIFO_UEBERZUG" &
	exec 3>"$FIFO_UEBERZUG"
	trap cleanup EXIT
	lf "$@" 3>&-
fi
