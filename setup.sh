# Symlink the dotfiles
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim

# Copy/update Go files, if Go is installed
if [-n "$GOROOT"]; then
	cp -r $GOROOT/misc/vim $(pwd)/vim
else
	echo "Go is not installed... you should install it.
fi

# Append zshrc shared settings to current zshrc
echo "source $HOME/dotfiles/zshrc" >> $HOME/.zshrc

