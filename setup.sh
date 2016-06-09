#!/usr/bin/env bash

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
    ln -s $(pwd)/vimrc $HOME/.vimrc
    ln -s $(pwd)/vim $HOME/.vim
    ln -s $(pwd)/fish $HOME/.config/fish
    ln -s $(pwd)/gitconfig $HOME/.gitconfig
    ln -s $(pwd)/gitignore $HOME/.gitignore
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
    
}

setup_dotfiles_simlink
