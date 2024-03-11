#!/usr/bin/env zsh

# provide cutom values for fzf
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p -h 80% -w 69% --layout=reverse --border"

# custom file finder
function _fzf_compgen_path() {
  rg --files --glob "!.git" . "$1"
}

# custom directory finder
function _fzf_compgen_dir() {
  fd --type=directory --hidden --follow --color=always --exclude=.git . "$1"
}

# custom run command
function _fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    tree)         fd . --type=directory | fzf --preview "tree -C {}" "$@";;
    *)            fzf "$@";;
  esac
}

# default utilities
\. "$DOTFILES/fzf/utils/completion.zsh"
\. "$DOTFILES/fzf/utils/key-bindings.zsh"

