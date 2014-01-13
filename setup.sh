# Symlink the dotfiles
ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim

# Append zshrc shared settings to current zshrc
echo "source $HOME/dotfiles/zshrc" >> $HOME/.zshrc
source $HOME/.zshrc

# Install Go
hg clone -u release https://code.google.com/p/go $HOME/go
pushd
cd $HOME/go/src
./all.bash
popd

# Copy/update Go files
cp -r $GOROOT/misc/vim $(pwd)

# Set gocode
go get -u github.com/nsf/gocode	
cp -r $GOPATH/src/github.com/nsf/gocode/vim $(pwd)

# Set golint
go get -u github.com/golang/lint/golint
cp -r $GOPATH/src/github.com/golang/lint/misc/vim $(pwd)

# VIM Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# VIM NERDTree
git clone https://github.com/scrooloose/nerdtree.git vim/bundle/nerdtree

# Syntastic
git clone https://github.com/scrooloose/syntastic.git vim/bundle/syntastic

# GoCode
git clone https://github.com/Blackrush/vim-gocode.git vim/bundle/vim-gocode
