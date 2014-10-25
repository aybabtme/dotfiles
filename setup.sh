GO_VERSION=1.3.3
GO_ROOT=$HOME # go tarball has a 'go/' folder

# helpers
command_exists() {
    hash $1 2> /dev/null
}

fetch_tgz() {
    if command_exists "curl"; then
	curl $1 | tar xz -C $2
    elif command_exists "wget"; then
	wget -qO- $1 | tar xz -C $2
    else
	echo "no curl or wget, cant fetch files"
	exit 1
    fi
}

setup_dotfiles_simlink() {
    # Symlink the dotfiles
    ln -s $(pwd)/tmux.conf $HOME/.tmux.conf
    ln -s $(pwd)/tmux $HOME/.tmux
    ln -s $(pwd)/emacs $HOME/.emacs
    ln -s $(pwd)/emacs.d $HOME/.emacs.d
    ln -s $(pwd)/vimrc $HOME/.vimrc
    ln -s $(pwd)/vim $HOME/.vim
    ln -s $(pwd)/fish $HOME/.config/fish
    ln -s $(pwd)/gitconfig $HOME/gitconfig
}

# Install Go
install_go_from_source() {
    mkdir -p $GO_ROOT
    if command_exists "hg" ; then
	hg clone -u release https://code.google.com/p/go $GO_ROOT/go
    else
	fetch_tgz https://storage.googleapis.com/golang/go$GO_VERSION.src.tar.gz $GO_ROOT/go
    fi
    pushd $GO_ROOT/src/
    ./all.bash
    popd
    
    # prepare go toolchain for x-compilation
    go get github.com/laher/goxc
    goxc -t
}

install_go_from_distribution() {
    mkdir -p $GO_ROOT
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
	fetch_tgz https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz $GO_ROOT
    elif [[ "$OSTYPE" == "darwin"* ]]; then
	fetch_tgz https://storage.googleapis.com/golang/go$GO_VERSION.darwin-amd64-osx10.8.tar.gz $GO_ROOT
    else
        echo "system not supported for Go distribution"
	exit 1
    fi
}

install_go_tools() {
    # go tools (vet/oracle/cover/rename)
    go get -u -v code.google.com/p/go.tools/cmd/...
    
    # golint
    go get -u -v github.com/golang/lint/golint
    
    # gocode
    go get -u -v github.com/nsf/gocode
    
    # godef
    go get -u -v code.google.com/p/rog-go/exp/cmd/godef
    
    # go flymake for emacs
    go get -u -v github.com/dougm/goflymake
}
