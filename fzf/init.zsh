#!/usr/bin/env zsh

\. "$DOTFILES/fzf/utils/completion.zsh" --silent
\. "$DOTFILES/fzf/utils/key-bindings.zsh" --silent

fzf_with_tmux() {
  script="$DOTFILES/fzf/utils/fzf-with-tmux"
  [[ ! -x script ]] && chmod +x "$script"
	\. "$script"
}
