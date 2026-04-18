#!/usr/bin/env fish

if status is-interactive
    if type -q zoxide
        zoxide init fish | source
    end
end

function keybinds_zeoxide
    bind \em 'zmux; commandline -f repaint'
end
