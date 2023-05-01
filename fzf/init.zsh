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

function __get_session_name() {
  full_path="$1"
  session_name=$(basename "$full_path")
  # if session_name starts with "." remove it"
  [[ $session_name == .* ]] && session_name=${session_name#.}
  # uppercase session_name and replace "." with "-"
  session_name=$(echo "$session_name" | tr '[:lower:]' '[:upper:]' | tr '.' '-')
  echo "$session_name"
}

function __create_tmux_session() {
  full_path=$(realpath "$1")
  session_name=$(__get_session_name "$full_path")
  # if not inside tmux
  if [[ -z "$TMUX" ]]; then
    # if session exists attach to it
    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux attach -t "$session_name"
    else
      # if session does not exist create it
      tmux new -s "$session_name" -c "$full_path"
    fi
  else
    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux switch-client -t "$session_name"
    else
      tmux new -s "$session_name" -d -c "$full_path"
      tmux switch-client -t "$session_name"
    fi
  fi
}

function ami-project() {
  cached_dir=$(pwd)
  cd "$HOME/AMI"
  dir_name=$(printf "%s\n" "$@" | fd . --type=d --max-depth=1 | fzf-tmux -p -h 81% -w 69% --layout="reverse" --border --prompt="🚀 Select Project  " --preview="exa -l {} --icons --git-ignore --no-user --no-time --sort type -T -L 6" --preview-window="bottom,25")
  if [[ -z $dir_name ]]; then
    info "No project was selected"
    return 0
  else
    __create_tmux_session "$dir_name"
  fi
  cd "$cached_dir"
}

function zmux() {
  selected=$(printf "%s\n" "$@" | z | fzf-tmux -p -h 81% -w 69% --border --prompt="🚀 Select Path  ")
  full_path=$(echo "$selected" | tr -s ' ' | cut -d ' ' -f 2)
  if [[ -z $full_path ]]; then
    info "No path was selected"
    return 0
  else
    __create_tmux_session "$full_path"
  fi
}
bindkey -s "\eo" "zmux\n"

function ssh-use() {
  profiles=("radvil-gitlab [Work]" "radvil-github [Personal]" "radvil2-github [Personal]")
  selected=$(printf "%s\n" "${profiles[@]}" | fzf --border --prompt="🔑 Select Key  ")
  if [[ -z $selected ]]; then
    warn "No key was selected"
    return 0
  else
    eval $(ssh-agent -s)
    selected=$(echo $selected | cut -d ' ' -f 1)
    ssh-add "$HOME/.ssh/$selected"
    okay "Selected key  $selected"
  fi
}

# default utilities
\. "$DOTFILES/fzf/utils/completion.zsh" --silent
\. "$DOTFILES/fzf/utils/key-bindings.zsh" --silent

