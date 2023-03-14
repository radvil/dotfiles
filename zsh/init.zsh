#NOTE: These should run in order!

source "$DOTFILES/common/funcs.sh"

source_file "$HOME/.cargo/env"
source_file "$HOME/.nvm/nvm.sh"
source_file "$HOME/.nvm/bash_completion"
# source_file "$DOTFILES/p10k/config.zsh"
source_file "$DOTFILES/omz/init.zsh"
source_file "$DOTFILES/starship/init.zsh"
source_file "$DOTFILES/fzf/init.zsh"
source_file "$DOTFILES/z/init.zsh"
source_file "$DOTFILES/alias/init.zsh"

PATH="$DOTFILES/bin:$PATH"
