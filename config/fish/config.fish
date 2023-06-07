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

switch (hostname)
case "codespaces*"
  if test -d "/workspaces/github"
    # don't set CDPATH as it doesn't work for dotcom
  else
    set -xg CDPATH "." "~"
  end
case "*"
  set -xg CDPATH "." "~"
end

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
set -xg GOEXPERIMENT "loopvar"

set --local host_spec $HOME/.config/fish/(hostname -s)_spec.fish

set fish_greeting ""

if test -f "$host_spec"
  . $host_spec
end


test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish
status --is-interactive; and source (rbenv init -|psub)
