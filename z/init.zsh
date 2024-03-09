Z_FILE="$DOTFILES/z/z.lua"
[ -f "$Z_FILE" ] || warn "file $Z_FILE was not found"
eval "$(lua $Z_FILE --init zsh)"
