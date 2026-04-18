#!/usr/bin/env bash

function setup() {
  local downloadDir="$HOME/Downloads/Programs/obs-plugins"
  mkdir "$downloadDir" -p
  sudo dnf download obs-studio-plugin-vkcapture --destdir="$downloadDir"
  sudo rpm -ivh --nodeps "$downloadDir/obs-studio-plugin-vkcapture*"
  sudo rm -rf "$downloadDir"

  local installer
  installer=$(dirname "$0")/install-apps.sh
  chmod +x "$installer"
  bash -c "$installer"
}

setup

unset setup
