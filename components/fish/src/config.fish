#!/usr/bin/env fish

# set -gx DOTFILES "/media/data/Projects/Personal/dotfiles"
# set -gx NOTES_DIR "$HOME/Documents/Notes"

function fish_greeting
    echo Yoo (set_color yellow)$USER(set_color normal), please stop being an asshole!\n
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_user_key_bindings
    keybinds_zeoxide
end
