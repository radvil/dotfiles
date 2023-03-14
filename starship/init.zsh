# ensure_installed starship || __install_starship
export STARSHIP_CONFIG="$RADVIL/starship/config.toml"
[ -f "$STARSHIP_CONFIG" ] || warn "$STARSHIP_CONFIG was not found!"
eval $(starship init zsh)
