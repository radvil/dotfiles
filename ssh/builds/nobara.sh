#!/usr/bin/env bash

function __log() {
  printf "[LOG] %s\n" "$1"
}

function __info() {
  printf "\e[34m[INFO]\e[0m %s\n" "$1"
}

function __install_ssh_profiles() {
  local gpg_key
  local src_dir
  local builds_dir
  local dest_dir="$HOME/.ssh"

  builds_dir="$(dirname "$(realpath "$0")")"
  src_dir="$(realpath "$builds_dir/../src")"

  # Ensure gpg-agent is running for passphrase caching
  gpg_key=$(tty)
  export GPG_TTY="$gpg_key"

  # Temporarily set the passphrase cache timeout to 1 minute (60 seconds)
  export GPG_AGENT_INFO="/tmp/gpg-agent-info"
  gpg-agent --daemon --default-cache-ttl 3 --max-cache-ttl 3

  if [ -z "${SSH_PROFILES+x}" ]; then
    mapfile -t SSH_PROFILES < <(
      find "$src_dir" -type f -name "*.gpg" -exec basename {} .gpg \; |
        sed 's/\.pub$//' |
        sort | uniq
    )
    export SSH_PROFILES
  fi

  __info "Installing SSH_PROFILES » ${SSH_PROFILES[*]}"

  [ -d "$dest_dir" ] || mkdir -p "$dest_dir"
  [ -f "$dest_dir/config" ] && rm -rf "$dest_dir/config"
  [ -f "$src_dir/config" ] && ln -sf "$src_dir/config" "$dest_dir/config"

  [[ -z "${SSH_AGENT_PID+x}" ]] || eval "$(ssh-agent -s)"

  for name in $SSH_PROFILES; do
    local profile_file_pub="$dest_dir/$name.pub"
    if [ -f "$profile_file_pub" ]; then
      __log "$profile_file_pub exists, skipping ..."
    else
      local original_file_pub="$src_dir/$name.pub.gpg"
      if [ -f "$original_file_pub" ]; then
        __log "decrypting $original_file_pub to $profile_file_pub"
        gpg --batch --use-agent -d -o "$profile_file_pub" "$original_file_pub"
        # gpg -d -o "$profile_file_pub" "$original_file_pub"
      fi
    fi

    local profile_file="$dest_dir/$name"
    if [ -f "$profile_file" ]; then
      __log "$profile_file exists, skipping ..."
    else
      local original_file="$src_dir/$name.gpg"
      if [ -f "$original_file" ]; then
        __log "decrypting $original_file to $profile_file"
        gpg --batch --use-agent -d -o "$profile_file" "$original_file"
        # gpg -d -o "$profile_file" "$original_file"
        chmod 600 "$profile_file"
        ssh-add "$profile_file"
      fi
    fi
  done
}

__install_ssh_profiles

unset __log
unset __info
unset __install_ssh_profiles
