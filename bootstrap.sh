#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function update() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE.txt" --exclude "brew.sh" \
    --exclude "apt.sh" -avh --no-perms . ~;
	source ~/.bash_profile;

  # Configure tmux
  if which tmux > /dev/null; then
    tmux source-file ~/.tmux.conf
  fi;
}

function install() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE.txt" --exclude "brew.sh" \
    --exclude "apt.sh" -avh --no-perms . ~;
	source ~/.bash_profile;

  # Configure tmux
  if which tmux > /dev/null; then
    tmux source-file ~/.tmux.conf
  fi;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	update;
	install;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ "$1" == "--update" -o "$1" == "-U" ]; then
  		update;
    else
  		update;
  		install;
    fi;
	fi;
fi;
unset update;
unset install;
