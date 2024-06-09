#!/usr/bin/env bash

if [ ! -x "$(command -v ssh)" ]; then
	sudo pacman -S openssh
fi

__SOURCE_DIR="$DOTFILES/ssh/src"
__TARGET_DIR="$HOME/.ssh"

[ -d "$__TARGET_DIR" ] || mkdir -p "$__TARGET_DIR"
[ -f "$__TARGET_DIR/config" ] && rm -rf "$__TARGET_DIR/config"
[ -f "$__SOURCE_DIR/config" ] && ln -sf "$__SOURCE_DIR/config" "$__TARGET_DIR/config"

if [ -z "${__DOT_SSH_PROFILES}" ]; then
  # read all filename in __SOURCE_DIR that matches "*.gpg"
  # dont take fullpath, just filename and store in __DOT_SSH_PROFILES
  # also make sure to remove duplicate value
  __DOT_SSH_PROFILES=($(ls -1 "$__SOURCE_DIR"/*gpg | xargs -n 1 basename | cut -d '.' -f 1 | uniq))
	export __DOT_SSH_PROFILES
fi

# make sure to start ssh-agent
[[ -z $SSH_AGENT_PID ]] || eval "$(ssh-agent -s)"

for __p in ${__DOT_SSH_PROFILES[@]}; do
  # split <space> and get first value ("radvil [work]" » "radvil")
  __ssh_profile="$(echo "$__p" | cut -d ' ' -f 1)";
	__source="$__SOURCE_DIR/$__ssh_profile.gpg"
	__source_pub="$__SOURCE_DIR/$__ssh_profile.pub.gpg"
	__target="$__TARGET_DIR/$__ssh_profile"
	__target_pub="$__TARGET_DIR/$__ssh_profile.pub"
	if [ -f "$__source" ]; then
		[ -f "$__target" ] && rm -rf "$__target"
		gpg -d -o "$__target" "$__source"
	fi
	if [ -f "$__source_pub" ]; then
		[ -f "$__target_pub" ] && rm -rf "$__target_pub"
		gpg -d -o "$__target_pub" "$__source_pub"
	fi
  chmod 600 "$__target"
  ssh-add "$__target"
done
