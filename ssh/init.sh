#!/bin/bash

# SSH Agent should be running, once
# proccess_count=$(ps -ef | pgrep "ssh-agent" | pgrep -v "grep" | wc -l)
# if [ "$proccess_count" -eq 0 ]; then
	echo "Starting SSH agent ..."
	eval "$(ssh-agent -s)"
# fi

ssh-add "$HOME/.ssh/radvil-gitlab"
ssh-add "$HOME/.ssh/radvil-github"
ssh-add "$HOME/.ssh/radvil2-github"
