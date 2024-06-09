#!/usr/bin/env bash

alias cl="clear"
alias rm="trash"
alias ls="eza"
alias ll='eza -alF'
alias la='eza -la'
alias grep="rg"
alias cat="bat -p"
alias mx="tmux"
alias v="NVIM_APPNAME=nvmini nvim"
alias vi="NVIM_APPNAME=nvmini nvim"
alias so-bash="source ~/.bashrc"
alias so-zsh="source ~/.zshenv"
alias purge-nvim-cache="rm -rf ~/.cache/nvim && rm -rf ~/.local/state/nvim"
alias n="nnn -P v"
alias N="sudo nnn -P v"
alias neofetch="fastfetch"
alias x="exit"
alias nvidid-status="sudo cat /sys/module/nvidia_drm/parameters/modeset"
alias update-initramfs="sudo mkinitcpio -P && sudo grub-mkconfig -o /boot/grub/grub.cfg"
