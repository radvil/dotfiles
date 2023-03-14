setup_file="$DOTFILES/z/z.lua"
[ -f "$setup_file" ] || warn "file $setup_file was not found"
eval "$(lua $setup_file --init zsh)"
