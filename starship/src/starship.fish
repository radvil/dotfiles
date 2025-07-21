#!/usr/bin/env fish

# set starship_src (dirname $(realpath (status -f)))
# set -gx STARSHIP_CONFIG (realpath "$starship_src/starship.toml")

if status is-interactive
    if type -q starship
        starship init fish | source
    end

    if set -q DISTROBOX_ENTER_PATH
        if type -q fastfetch
            fastfetch
        end
    end
end
