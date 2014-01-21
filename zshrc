autoload -Uz compinit vcs_info

compinit

export EDITOR=vim

# Set the prompt
source $HOME/dotfiles/prompt

# Alias
alias gb="git branch"
alias gco="git checkout"
alias gl="git log --graph --decorate --pretty=oneline --abbrev-commit --color='Always'"
alias gla="git log --graph --decorate --pretty=oneline --abbrev-commit --all"
alias gs="git status"

alias ls="ls -G"
alias ll="ls -Glh"
alias la="ls -Glah"

alias tailf="tail -f"

alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'

alias bach="ssh -i $HOME/key/bach.pem ubuntu@23.23.83.39"
alias tbach="ssh -i $HOME/key/bach.pem ubuntu@23.23.83.39 -t tmux a"

# Path and GoPath
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/gocode/bin:$PATH

export GOPATH=$HOME/gocode
export GOROOT=$HOME/go
