autoload -Uz compinit vcs_info
setopt inc_append_history
setopt share_history
compinit
set -o vi

export EDITOR=emacs

# Set the prompt
source $HOME/dotfiles/prompt

alias ll="ls -Glh"
alias la="ls -Glah"
alias ls="la"

alias tailf="tail -f"

alias tvpn="ssh -p 443 antoine@vpn.antoine.im -t tmux a"
alias svpn="ssh -p 443 antoine@vpn.antoine.im"
alias vpn="ssh -ND 12345 -p 443 antoine@vpn.antoine.im"

# Path and GoPath
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/gocode/bin:$PATH

export GOPATH=$HOME/gocode
export GOROOT=$HOME/go
export CDPATH=$CDPATH:$GOPATH/src