autoload -Uz compinit vcs_info
setopt inc_append_history
setopt share_history
compinit
set -o vi

export EDITOR=vim

# Set the prompt
source $HOME/dotfiles/prompt

# Alias
alias gb="git branch"
alias gco="git checkout"
alias gl="git log --graph --decorate --pretty=oneline --abbrev-commit --color='Always'"
alias gla="git log --graph --decorate --pretty=oneline --abbrev-commit --all"
alias gs="git status"

alias ll="ls -Glh"
alias la="ls -Glah"
alias ls="la"

alias tailf="tail -f"

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

alias bach="ssh -i $HOME/key/bach.pem ubuntu@23.23.83.39"
alias tbach="ssh -i $HOME/key/bach.pem ubuntu@23.23.83.39 -t tmux a"

alias tvpn="ssh -p 443 antoine@vpn.antoine.im -t tmux a"
alias svpn="ssh -p 443 antoine@vpn.antoine.im"
alias vpn="ssh -ND 12345 -p 443 antoine@vpn.antoine.im"

export AWS_ACCESS_KEY="`cat $HOME/key/genghis.aws.access`"
export AWS_SECRET_KEY="`cat $HOME/key/genghis.aws.secret`"

# Path and GoPath
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/gocode/bin:$PATH

export GOPATH=$HOME/gocode
export GOROOT=$HOME/go
export CDPATH=$CDPATH:$GOPATH/src

export COREOS_IPXE_SERVER_DATA_DIR=$HOME/coreos/coreos-ipxe-server
