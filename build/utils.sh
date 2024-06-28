#!/usr/bin/env zsh
# shellcheck disable=SC2046,2086,SC2181,1090

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
  return 0
}

error() {
  echo -e "\033[31m$1\033[0m"
  return 0
}

confirmed() {
	read -r -p "[❓] $1 [Y/n] >> " answer
	answer=${answer,,} # tolower
	if [[ $answer =~ ^(y| ) ]] || [[ -z $answer ]]; then
		return 0
	else
		return 1
	fi
}

setup_link() {
	local src="$1" dst="$2"
	if [ -d "$src" ]; then
		if [ ! -d "$dst" ]; then
			ln -sf "$src" "$dst"
			okay "linked dir \"$1\" >> \"$2\""
		else
			if confirmed "\"$dst\" already exists, do you wanna replace it ?"; then
				rm -rf "$dst"
				ln -sf "$src" "$dst"
				okay "linked \"$1\" >> \"$2\""
			else
				warn "\"$1\" to \"$2\" [skipped]"
			fi
		fi
	else
		if [ ! -f "$dst" ]; then
			ln -sf "$src" "$dst"
			okay "linked file \"$1\" >> \"$2\""
		else
			if confirmed "\"$dst\" already exists, do you wanna replace it ?"; then
				rm -rf "$dst"
				ln -sf "$src" "$dst"
				okay "linked \"$1\" >> \"$2\""
			else
				warn "\"$1\" to \"$2\" [skipped]"
			fi
		fi
	fi
}

source_file() {
	if [ -s "$1" ]; then
		#shellcheck source=/dev/null
    [[ "$2" != "--silent" ]] && info "sourcing $1"
		source "$1"
	else
		warn "file $1 doesn't exist! [skipped]"
	fi
}

install_packages() {
	local sources="$1"
	info "installing common dependencies.."
	sudo dnf install $(cat $sources)
	if [[ ! $? -eq 0 ]]; then
		warn "failed during dependencies installation!"
	else
		okay "dependencies installed successfully!"
	fi
}

has_installed() {
	cmdname="$(command -v "$1" 2>/dev/null)"
	[[ -x "$cmdname" ]]
}
