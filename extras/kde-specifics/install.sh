#!/usr/bin/env bash

[[ $DOTFILES_UTILS_LOADED -eq 0 ]] && source "$DOTFILES/build/utils.sh"

# install kwin bismuth tiling window
if confirmed "Do you wanna install \"kwin-bismuth\"?"; then
  yay -S kwin-bismuth --needed
fi

# link previous global shortcuts
if confirmed "Do you wanna use your previous \"kde global shortcuts\" config?"; then
  config_file="$HOME/.config/kglobalshortcutsrc"
  [[ -f "$config_file" ]] && mv "$config_file" "$config_file.bak"
  setup_link "$DOTFILES/extras/kde-specifics/kglobalshortcutsrc" "$config_file"
fi

# link previous kwin config
if confirmed "Do you wanna use your previous \"kwin\" config?"; then
  config_file="$HOME/.config/kwinrc"
  [[ -f "$config_file" ]] && mv "$config_file" "$config_file.bak"
  setup_link "$DOTFILES/extras/kde-specifics/kwinrc" "$config_file"
fi
