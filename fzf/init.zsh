#!/usr/bin/env zsh

# provide cutom values for fzf
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p -h 80% -w 60% --layout=reverse --border"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#30303b,bg:#202027,spinner:#f4dbd6,hl:#ff657a \
--color=fg:#ACB6D2,header:#ff657a,info:#b18eab,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#ACB6D2,prompt:#b18eab,hl+:#ff657a"

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

# load bultin functions
\. "$DOTFILES/fzf/utils/completion.zsh"
\. "$DOTFILES/fzf/utils/key-bindings.zsh"

