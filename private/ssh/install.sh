#!/usr/bin/env bash

[[ -d "$HOME/.ssh" ]]  || mkdir "$HOME/.ssh"
[[ -f "$HOME/.ssh/config" ]] && mv "$HOME/.ssh/config" "$HOME/.ssh/config.bak"
setup_link "$DOTFILES/private/ssh/config" "$HOME/.ssh/config"
sudo chmod +x "$DOTFILES/private/ssh/autorun.sh"
sudo ln -sf "$DOTFILES/private/ssh/startup.service" "/etc/systemd/system/radvil-ssh.service"
sudo systemctl enable radvil-ssh.service

SSH_KEY_TYPE="ed25519"

if confirmed "Setup ssh for AMI Workspace?"; then
  [[ -d "$HOME/.ssh/work" ]]  || mkdir "$HOME/.ssh/work"
  KEY_GITLAB_AMI="$HOME/.ssh/work/gitlab_ami_$SSH_KEY_TYPE"
  UID_GITLAB_AMI="radvil@access-mobile.com"
  if [[ ! -f "$KEY_GITLAB_AMI" ]]; then
    ssh-keygen -t "$SSH_KEY_TYPE" -C "$UID_GITLAB_AMI" -f "$KEY_GITLAB_AMI"
    sed -i '/^##gitlab.ami.com$/,+4 s/#//' "$DOTFILES/private/ssh/config"
  fi
 xclip -selection c "$KEY_GITLAB_AMI.pub"
 info "Public key $KEY_GITLAB_AMI.pub has copied to clipboard"
fi

if confirmed "Setup ssh for github.radvil.com?"; then
  [[ -d "$HOME/.ssh/personal" ]]  || mkdir "$HOME/.ssh/personal"
  KEY_GITHUB_RADVIL="$HOME/.ssh/personal/github_radvil_$SSH_KEY_TYPE"
  UID_GITHUB_RADVIL="radvil.linux@gmail.com"
  if [[ ! -f "$KEY_GITHUB_RADVIL" ]]; then
    ssh-keygen -t "$SSH_KEY_TYPE" -C "$UID_GITHUB_RADVIL" -f "$KEY_GITHUB_RADVIL"
    sed -i '/^##github.radvil.com$/,+4 s/#//' "$DOTFILES/private/ssh/config"
  fi
 xclip -selection c "$KEY_GITHUB_RADVIL.pub"
 info "Public key $KEY_GITHUB_RADVIL.pub has copied to clipboard"
fi

if confirmed "Setup ssh for github.radvil2.com?"; then
  [[ -d "$HOME/.ssh/personal" ]]  || mkdir "$HOME/.ssh/personal"
  KEY_GITHUB_RADVIL2="$HOME/.ssh/personal/github_radvil2_$SSH_KEY_TYPE"
  UID_GITHUB_RADVIL2="radvil.developer@gmail.com"
  if [[ ! -f "$KEY_GITHUB_RADVIL2" ]]; then
    ssh-keygen -t "$SSH_KEY_TYPE" -C "$UID_GITHUB_RADVIL2" -f "$KEY_GITHUB_RADVIL2"
    sed -i '/^##github.radvil2.com$/,+4 s/#//' "$DOTFILES/private/ssh/config"
  fi
 xclip -selection c "$KEY_GITHUB_RADVIL2.pub"
 info "Public key $KEY_GITHUB_RADVIL2.pub has copied to clipboard"
fi

sudo systemctl start radvil-ssh.service

okay "radvil-ssh.service has been enabled successfully!"
