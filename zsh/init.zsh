#NOTE: These should run in order!

# requirement utils
source "$DOTFILES/common/funcs.sh"

# source config
source_file "$HOME/.cargo/env"
source_file "$HOME/.nvm/nvm.sh"
source_file "$HOME/.nvm/bash_completion"
# source_file "$DOTFILES/p10k/config.zsh"
source_file "$DOTFILES/omz/init.zsh"
source_file "$DOTFILES/starship/init.zsh"
source_file "$DOTFILES/fzf/init.zsh"
source_file "$DOTFILES/fzf/funcs.sh"
source_file "$DOTFILES/z/init.zsh"
source_file "$DOTFILES/git/funcs.sh"
source_file "$DOTFILES/lf/funcs.sh"
source_file "$DOTFILES/alias/init.zsh"

# append path to global
PATH="$DOTFILES/bin:$PATH"
