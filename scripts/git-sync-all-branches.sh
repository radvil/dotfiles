#!/usr/bin/bash

# shellcheck source=/dev/null
source "$HOME/.radvil/_utils.sh"
## @ref https://stackoverflow.com/questions/10312521/how-do-i-fetch-all-git-branches
ensure_installed git || error "git was not installed"
git branch -r | grep -v '\->' | sed "s,\x1b\[[0-9;]*[a-za-z],,g" | while read -r remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
