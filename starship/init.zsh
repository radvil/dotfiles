# ensure_installed starship || __install_starship
export STARSHIP_CONFIG="$DOTFILES/starship/config.toml"
[ -f "$STARSHIP_CONFIG" ] || warn "$STARSHIP_CONFIG was not found!"
eval $(starship init zsh)
