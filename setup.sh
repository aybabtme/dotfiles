#!/usr/bin/env bash

root=$(git rev-parse --show-toplevel)

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
    ln -s ${root}/tmux.conf $HOME/.tmux.conf
    ln -s ${root}/tmux $HOME/.tmux
    ln -s ${root}/vimrc $HOME/.vimrc
    ln -s ${root}/vim $HOME/.vim
    ln -s ${root}/fish $HOME/.config/fish
    ln -s ${root}/gitconfig $HOME/.gitconfig
    ln -s ${root}/gitignore $HOME/.gitignore
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
