#!/bin/bash

function __throw() {
  echo -e "\033[31m[❌ERR]\033[0m $1"
  return 1
}

function remove-history() {
  [[ -z "$1" ]] && __throw "Please provide the search term!"
  cp "$HOME/.zsh_history" "$HOME/.zsh_history.bak"
  grep -v "$1" "$HOME/.zsh_history" > "$HOME/.cache/zsh_history"
  mv "$HOME/.cache/zsh_history" "$HOME/.zsh_history"
  okay "History of '$1' removed!"
}

function cmd-window() {
  [[ -z "$TMUX" ]] && __throw "Should run inside tmux!"
  [[ -z "$1" ]] && __throw "Please provide a command!"
  local name="command-line"
  if tmux list-windows -F '#{window_name}' | grep -q "$name"; then
    tmux select-window -t "$name"
  else
    tmux new-window -d -n "$name" -c "#{pane_current_path}"
  fi
  tmux send-keys -t "$name" "$1" Enter
  if [[ "$2" == "--switch" || "$2" == "-s" ]]; then
    tmux select-window -t "$name"
  fi
}

function cmd-session() {
  local cmd="$1"
  local cwd="$(pwd)"
  local name="CMDLINE"
  if [[ -z "$cmd" ]]; then
    __throw "Please provide a command!"
  else
    if [[ -z "$TMUX" ]]; then
      if tmux has-session -t "$name" 2>/dev/null; then
        tmux attach -t "$name" \; \
          send-keys "$cmd" Enter
      else
        tmux new -s "$name" -c "$cwd" \; \
          send-keys -t "$name" "$cmd" Enter
      fi
    else
      if tmux has-session -t "$name" 2>/dev/null; then
        tmux switch-client -t "$name"
      else
        tmux new -s "$name" -d -c "$cwd"
        tmux switch-client -t "$name"
      fi
      tmux send-keys -t "$name" "$cmd" Enter
    fi
  fi
}

function run-in-popup() {
  tmux popup -h 90% -w 90% -S padded -E "$1"
}

function lg() {
  if [[ -z "$TMUX" ]]; then
    lazygit
  else
    run-in-popup lazygit
  fi
}
