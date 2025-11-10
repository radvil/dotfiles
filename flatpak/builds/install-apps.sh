#!/usr/bin/env bash

function setup() {
  __success() {
    printf "\e[32m[SUCCESS]\e[0m %s\n" "$1"
  }

  function __info() {
    printf "\e[34m[INFO]\e[0m %s\n" "$1"
  }

  flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo --system
  flatpak install flathub-beta com.discordapp.DiscordCanary --system -y

  flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo --system

  local userApps=(
    "ca.edestcroix.Recordbox"
    "com.github.wwmm.easyeffects"
    "com.microsoft.Edge"
    # "com.obsproject.Studio"
    "com.obsproject.Studio.Plugin.AitumMultistream"
    "com.obsproject.Studio.Plugin.DroidCam"
    "com.obsproject.Studio.Plugin.OBSVkCapture"
    "com.obsproject.Studio.Plugin.waveform"
    "dev.qwery.AddWater"
    "io.github.flattool.Warehouse"
    "io.github.slgobinath.SafeEyes"
    "com.github.tchx84.Flatseal"
    "md.obsidian.Obsidian"
    "org.freedesktop.Platform.VulkanLayer.vkBasalt/x86_64/23.08"
    "org.gnome.clocks"
    "org.gtk.Gtk3theme.Breeze"
    "org.gtk.Gtk3theme.Orchis-Dark"
    "org.gtk.Gtk3theme.adw-gtk3"
    "org.gtk.Gtk3theme.adw-gtk3-dark"
    "org.kde.haruna"
    "org.kde.kdenlive"
    "org.mozilla.firefox"
    "org.nickvision.tubeconverter"
    "com.dec05eba.gpu_screen_recorder"
  )

  flatpak install --system --noninteractive "${userApps[@]}" -y &&
    # flatpak install --system "${userApps[@]}" -y &&
    __success "flatpak packages installed successfully" &&
    __info "Please restore the app's configs on 'src/apps.zip' manually!"
}

setup

unset setup
