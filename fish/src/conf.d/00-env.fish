#!/usr/bin/env fish

set script_dir (dirname $(realpath (status --current-filename)))
set env_file "$script_dir/../../../core/src/env/global.env"

if test -f $env_file
    for line in (cat $env_file)
        # Skip comments or empty lines
        if test (string sub -l 1 -- $line) = "#" || test -z "$line"
            continue
        end

        # Split key=value
        set key (string split -m 1 "=" $line)[1]
        set value (string split -m 1 "=" $line)[2]

        if test "$key" = PATH_EXTRA
            # Split PATH_EXTRA into array
            set extra_paths (string split " " $value)
        else
            # Expand variables like $HOME in value
            set expanded (eval echo $value)
            set -gx $key $expanded
        end
    end
end

# Append valid paths from PATH_EXTRA
if set -q extra_paths
    for dir in $extra_paths
        set expanded_dir (eval echo $dir)
        if test -d $expanded_dir
            set -gx PATH $expanded_dir $PATH
        end
    end
end
