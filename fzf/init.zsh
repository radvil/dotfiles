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

function ami-project() {
  cached_dir=$(pwd)
  cd "$HOME/AMI"
  target_dir=$(printf "%s\n" "$@" | fd . --type=d --max-depth=1 | fzf-tmux -p -h 50% -w 69% --border --prompt="🚀 Select Project  " --preview="exa -l {} --icons --git-ignore --no-user --no-time --sort type -T -L 6" --preview-window="right,90,wrap")
  if [[ -z $target_dir ]]; then
    echo "Nothing was selected"
    cd "$cached_dir"
    return 0
  else
    cd "$target_dir" && nvim
  fi
}


# default utilities
\. "$DOTFILES/fzf/utils/completion.zsh" --silent
\. "$DOTFILES/fzf/utils/key-bindings.zsh" --silent

