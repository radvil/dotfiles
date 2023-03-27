#!/bin/bash

  # SSH Agent should be running, once
  # proccess_count=$(ps -ef | pgrep "ssh-agent" | pgrep -v "grep" | wc -l)
  # if [ "$proccess_count" -eq 0 ]; then
  echo "Starting SSH agent ..."
  eval "$(ssh-agent -s)"
  # fi
  ssh-add "/home/radvil/.ssh/work/gitlab_ami_ed25519"
  ssh-add "/home/radvil/.ssh/personal/github_radvil_ed25519"
  ssh-add "/home/radvil/.ssh/personal/github_radvil2_ed25519"
