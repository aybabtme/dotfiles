# Symlink the dotfiles
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim

# Append zshrc shared settings to current zshrc
echo "source $HOME/dotfiles/zshrc" >> $HOME/.zshrc

# Copy/update Go files, if Go is installed
if [ -n "$GOROOT" ]; then
	cp -r $GOROOT/misc/vim $(pwd)

	# Set gocode
	go get -u github.com/nsf/gocode	
#	cp -r $GOPATH/src/github.com/nsf/gocode/vim $(pwd)

	# Set golint
	go get -u github.com/golang/lint/golint
#	cp -r $GOPATH/src/github.com/golang/lint/misc/vim $(pwd)
else
	echo "Go is not installed... you should install it."
fi
