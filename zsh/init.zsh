#NOTE: These should run in order!

source "$RADVIL/common/funcs.sh"

source_file "$HOME/.cargo/env"
source_file "$HOME/.nvm/nvm.sh"
source_file "$HOME/.nvm/bash_completion"
# source_file "$RADVIL/p10k/config.zsh"
source_file "$RADVIL/omz/init.zsh"
source_file "$RADVIL/starship/init.zsh"
source_file "$RADVIL/fzf/init.zsh"
source_file "$RADVIL/z/init.zsh"
source_file "$RADVIL/alias/init.zsh"

PATH="$RADVIL/bin:$PATH"
