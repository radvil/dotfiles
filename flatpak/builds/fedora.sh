#!/usr/bin/env bash

function setup() {
  __success() {
    printf "\e[32m[SUCCESS]\e[0m %s\n" "$1"
  }

  # NOTE: I wonder if I should enable this by default?
  # local configZip
  # configZip=$(realpath "components/flatpak/src/apps.zip")
  # unzip -o -d "$HOME/.var/app" "$configZip"

  sudo dnf download obs-studio-plugin-vkcapture --destdir=~/Downloads
  sudo rpm -ivh --nodeps ~/Downloads/obs-studio-plugin-vkcapture

  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo --user

  local userApps=(
    "ca.edestcroix.Recordbox"
    "com.discordapp.Discord"
    "com.github.wwmm.easyeffects"
    "com.microsoft.Edge"
    "com.obsproject.Studio"
    "com.obsproject.Studio.Plugin.AitumMultistream"
    "com.obsproject.Studio.Plugin.DroidCam"
    "com.obsproject.Studio.Plugin.OBSVkCapture"
    "com.obsproject.Studio.Plugin.waveform"
    "com.usebottles.bottles"
    "dev.qwery.AddWater"
    "fr.handbrake.ghb"
    "io.github.flattool.Warehouse"
    "io.freetubeapp.FreeTube"
    "io.github.slgobinath.SafeEyes"
    "com.github.tchx84.Flatseal"
    "io.github.thetumultuousunicornofdarkness.cpu-x"
    "it.mijorus.gearlever"
    "md.obsidian.Obsidian"
    "org.freedesktop.Platform.VulkanLayer.vkBasalt/x86_64/23.08"
    "org.gnome.clocks"
    "org.gnome.Decibels"
    "org.gtk.Gtk3theme.Breeze"
    "org.gtk.Gtk3theme.Orchis-Dark"
    "org.gtk.Gtk3theme.adw-gtk3"
    "org.gtk.Gtk3theme.adw-gtk3-dark"
    "org.kde.haruna"
    "org.kde.kdenlive"
    "org.mozilla.firefox"
    "org.nickvision.tubeconverter"
  )

  flatpak install --user "${userApps[@]}" -y
  __success "flatpak packages installed successfully"
}

setup

unset setup
