#!/usr/bin/env sh

cd ..

DOTFILES=$(pwd -P)
USERNAME=$(whoami)

sudo chown -R "$USERNAME" "$DOTFILES"

set -e

printf "Init dotfiles at %s$DOTFILES...\n"

# shellcheck source="./utils.sh"
\. "$DOTFILES/build/utils.sh"
\. "$DOTFILES/build/prerequiresites.sh"
\. "$DOTFILES/build/post-installation.sh"
