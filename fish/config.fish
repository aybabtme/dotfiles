# Path
set -xg PATH "/usr/bin" $PATH
set -xg PATH "/bin" $PATH
set -xg PATH "/usr/sbin" $PATH
set -xg PATH "/sbin" $PATH
set -xg PATH "$HOME/go/bin" $PATH

# Homebrew install folder should come first
if test -d "/usr/local/sbin"
  set -xg PATH $PATH "/usr/local/sbin"
end

set -xg GOPATH "$HOME/gocode" $GOPATH
set -xg PATH "$GOPATH/bin" $PATH
set -xg CDPATH $CDPATH "$GOPATH/src" . ~


set -xg EDITOR "nvim"
set -xg ALTERNATE_EDITOR ""
set -xg BUNDLE_EDITOR "nvim"
set -xg PAGER "less"

set --local host_spec $HOME/dotfiles/fish/(hostname -s)_spec.fish

set fish_greeting ""

if test -f "$host_spec"
  . $host_spec
end
