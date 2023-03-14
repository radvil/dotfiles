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

alias ff='fzf_via_tmux'
alias lr='lf_with_preview_support'
alias lgs='lazygit_with_cwd_switch'

