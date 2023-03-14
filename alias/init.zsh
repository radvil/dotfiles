#!/usr/bin/env bash

alias ls="exa"
alias ll='exa -alF'
alias la='exa -la'
alias grep="rg"

alias mx="tmux"
alias v="nvim"
alias vi="nvim"

alias so-bash="source ~/.bashrc"
alias so-zsh="source ~/.zshrc"

alias lg="lazygit"
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias lgd='lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME'

alias edit-nvimrc="vi ~/.config/nvim/init.lua"
alias purge-nvim-cache="rm -rf ~/.cache/nvim && rm -rf ~/.local/state/nvim"
alias forecast="curl wttr.in/Kendari"

## custom shell scripts
alias lr='source $DOTFILES/scripts/lf-with-img-preview.sh'
alias ff='source $DOTFILES/scripts/fzf-with-tmux-pane.sh'
alias lgs='source $DOTFILES/scripts/lazy-git-with-cd.sh'
alias git-sync='source $DOTFILES/scripts/git-sync-all-branches.sh'
alias dot-purge-branch='source $DOTFILES/scripts/dot-purge-branch.sh'

