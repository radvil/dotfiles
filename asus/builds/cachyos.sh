#!/usr/bin/env bash

function setup() {
  paru -S asusctl supergfxctl plasma6-applets-supergfxctl rog-control-center --noconfirm
  sudo systemctl start asusd && sudo systemctl enable supergfxd --now

  sudo systemctl daemon-reload &&
  sudo systemctl start asusd &&
  sudo systemctl enable supergfxd --now
}

setup

unset setup
