#!/usr/bin/env bash
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
	exit
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
			ln -s "$src" "$dst"
			okay "linked dir \"$1\" >> \"$2\""
		else
			if confirmed "\"$dst\" already exists, do you wanna replace it ?"; then
				trash -rf "$dst"
				ln -s "$src" "$dst"
				okay "linked \"$1\" >> \"$2\""
			else
				warn "\"$1\" to \"$2\" [skipped]"
			fi
		fi
	else
		if [ ! -f "$dst" ]; then
			ln -s "$src" "$dst"
			okay "linked file \"$1\" >> \"$2\""
		else
			if confirmed "\"$dst\" already exists, do you wanna replace it ?"; then
				trash -rf "$dst"
				ln -s "$src" "$dst"
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
		source "$1"
	else
		warn "file $dst doesn't exist! [skipped]"
	fi
}

custom_install() {
	if [ -s "$1/install.sh" ]; then
		chmod +x "$1/install.sh"
    #shellcheck source=/dev/null
		source "$1/install.sh"
	else
		warn "file $dst doesn't exist! [skipped]"
	fi
}

ensure_deps() {
	local sources="$1"
	info "installing common dependencies.."
	sudo apt install $(cat $sources) -y
	if [[ ! $? -eq 0 ]]; then
		warn "failed during dependencies installation!"
	else
		okay "dependencies installed successfully!"
	fi
}

ensure_exec() {
	cmdname="$(command -v "$1" 2>/dev/null)" || cmdname="$(dirname "$0")/$1"
	[[ -x "$cmdname" ]] || "$2" || fail "$cmdname not found"
}

copy_scripts() {
	local src_dir="$1"
	if [ -d "$src_dir" ]; then
		chmod +x -R "$src_dir"
		echo "sudo cp $src_dir/* /usr/local/bin/ -r" | bash
		okay "copied $src_dir/* to /usr/local/bin/"
	else
		warn "scripts $src_dir directory doesn't exist! [skipped]"
	fi
}

copy_binaries() {
	local src_dir="$1"
	if [ -d "$src_dir" ]; then
		echo "sudo cp $src_dir/* /usr/bin/ -r" | bash
		okay "copied $src_dir/* to /usr/bin/"
	else
		warn "binnaries $src_dir directory doesn't exist! [skipped]"
	fi
}
