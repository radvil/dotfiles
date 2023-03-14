#!/usr/bin/env bash
# shellcheck disable=1090

info() {
	printf "[\033[00;34m🚀INFO\033[0m] %s$1\n"
}

warn() {
	printf "[\033[0;33m⚠ WARN\033[0m] %s$1\n"
}

okay() {
	printf "\033[2K[\033[00;32m✔ OKAY\033[0m] %s$1\n"
}

fail() {
	printf "\033[2K[\033[0;31m❌FAIL\033[0m] %s$1\n"
	exit
}

setup_link() {
	local src="$1" dst="$2"
	if [ -d "$src" ]; then
		if [ ! -d "$dst" ]; then
			info "directory $dst doesnt exists!"
			okay "directory $dst created!"
			ln -s "$src" "$dst"
			okay "linked dir $1 >> $2"
		else
			warn "dir $dst already exists! [skipped]"
		fi
	else
		if [ ! -f "$dst" ]; then
			ln -s "$src" "$dst"
			okay "linked file $1 >> $2"
		else
			warn "file $dst already exists! [skipped]"
		fi
	fi
}

source_file() {
	if [ -s "$1" ]; then
		#shellcheck source=/dev/null
		source "$1"
	else
		warn "file $dst doesn't exist! [skipped]"
	fi
}

ensure_exec() {
	cmdname="$(command -v "$1" 2>/dev/null)" || cmdname="$(dirname "$0")/$1"
	[[ -x "$cmdname" ]] || fail "$cmdname not found"
}
