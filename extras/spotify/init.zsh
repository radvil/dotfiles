#!/usr/env/bin bash

function sp() {
  if ! pgrep -x "spotifyd" > /dev/null; then
    # spotifyd --no-daemon &
    spotifyd
  fi
  local session_name="SPOTIFY"
  if [[ -z "$TMUX" ]]; then
    if tmux has-session -t $session_name 2>/dev/null; then
      tmux attach -t $session_name
    else
      tmux new -s "$session_name" -c "$HOME" spt
      tmux switch-client -t $session_name
    fi
  else
    if tmux has-session -t $session_name 2>/dev/null; then
      tmux switch-client -t $session_name
    else
      tmux new -s $session_name -d -c "$HOME" spt
      tmux switch-client -t $session_name
      # tmux send-keys -t $session_name "spt" C-m
    fi
  fi
}
# bindkey -s "\ep" "sp\n"
