#!/usr/bin/env bash

function setup() {
  sudo dnf copr enable -y lukenukem/asus-linux
  sudo dnf copr enable -y jhyub/supergfxctl-plasmoid
  sudo dnf update --refresh
  sudo dnf install -y asusctl supergfxctl asusctl-rog-gui supergfxctl-plasmoid
  sudo systemctl daemon-reload &&
  sudo systemctl start asusd &&
  sudo systemctl enable supergfxd --now
}

setup

unset setup
