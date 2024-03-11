#!/usr/bin/env bash

## Node Version Manager
if [ ! -d "$HOME/.nvm" ]; then
	NVM_DIR="$HOME/.nvm"
	info "Installing \"Node Version Manager\"..."
	git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
	pushd "$NVM_DIR" || exit
	git checkout "$(git describe --abbrev=0 --tags --match "v[0-9]*" "$(git rev-list --tags --max-count=1)")"
	popd || exit
	source_file "$NVM_DIR/nvm.sh"
	okay "\"Node Version Manager\" installed successfully!"
	# Install nodejs packages globally
	info "Installing global npm modules..."
	nvm install v14
	nvm alias default 14
	npm install -g @angular/cli@13
	nvm install --lts
	nvm use --lts
	npm install -g @angular/cli@latest
	okay "Global node modules installed successfully!"
else
	info "\"Node Version Manager\" has already installed. Skipping..."
fi
