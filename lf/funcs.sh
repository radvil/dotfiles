#!/bin/bin/env bash

set -e

__cleanup_custom_lf() {
	exec 3>&-
	rm "$FIFO_UEBERZUG"
}

lf_with_preview_support() {
	ensure_exec lf
	ensure_exec ueberzug
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		lf "$@"
	else
		[ ! -d "$HOME/.cache/lf" ] && mkdir --parents "$HOME/.cache/lf"
		export FIFO_UEBERZUG="$HOME/.cache/lf/ueberzug-$$"
		mkfifo "$FIFO_UEBERZUG"
		ueberzug layer -s -p json <"$FIFO_UEBERZUG" &
		exec 3>"$FIFO_UEBERZUG"
		trap __cleanup_custom_lf EXIT
		lf "$@" 3>&-
	fi
}
