# Path
set -xg PATH "/usr/bin" $PATH
set -xg PATH "/bin" $PATH
set -xg PATH "/usr/sbin" $PATH
set -xg PATH "/sbin" $PATH
set -xg PATH "/usr/local/bin" $PATH

# Homebrew install folder should come first
if test -d "/usr/local/sbin"
  set -xg PATH $PATH "/usr/local/sbin"
end

set -xg CDPATH "." "~"

if test -d "$HOME/code"
  set -xg GOPATH "$HOME/code" $GOPATH
  set -xg PATH "$GOPATH/bin" $PATH
  set -xg CDPATH "$GOPATH/src" $CDPATH
end

if test -d "$HOME/go/bin"
  set -xg PATH "$HOME/go/bin" $PATH
end

set -xg GIT_EDITOR "vim"
set -xg EDITOR "vim"
set -xg ALTERNATE_EDITOR ""
set -xg BUNDLE_EDITOR "vim"
set -xg PAGER "less"
# set -xg GOEXPERIMENT "loopvar"

eval (/opt/homebrew/bin/brew shellenv)
set --local host_spec $HOME/.config/fish/(hostname -s)_spec.fish

set fish_greeting ""

if test -f "$host_spec"
  . $host_spec
end


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
