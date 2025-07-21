#!/usr/bin/env fish

set aliases_basedir "$DOTFILES/core/src/aliases"
set shared_aliases "$aliases_basedir/shared.aliases"
set fish_aliases "$aliases_basedir/fish.aliases"

if test -f $shared_aliases
    for line in (cat $shared_aliases)
        # skip comments or empty lines
        if test (string sub -l 1 -- $line) = "#" || test -z "$line"
            continue
        end
        set key (string split -m 1 "=" $line)[1]
        set value (string split -m 1 "=" $line)[2]
        if test -n "$key"
            alias $key="$value"
        end
    end
end

if test -f $fish_aliases
    source $fish_aliases
end
