#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE.txt" --exclude "brew.sh" \
    --exclude "apt.sh" -avh --no-perms . ~;
	source ~/.bash_profile;

  # Configure tmux
  if which tmux > /dev/null; then
    tmux source-file ~/.tmux.conf
  fi;

  # Install/Update neovim vim-plug plugin
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim --headless +PlugInstall +quitall

  # Install YCM with C-family support
  cd ~/.local/share/nvim/plugged/YouCompleteMe && ./install.py --clang-completer
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
