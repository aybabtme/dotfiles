# Path
set -xg PATH "/opt/local/bin" "/opt/local/sbin" $PATH
set -xg PATH "/usr/bin" $PATH
set -xg PATH "/bin" $PATH
set -xg PATH "/usr/sbin" $PATH
set -xg PATH "/sbin" $PATH
set -xg PATH "/opt/X11/bin" $PATH
set -xg PATH "/Applications/Postgres.app/Contents/Versions/9.3/bin" $PATH
set -xg PATH "$HOME/go/bin" $PATH

# Homebrew install folder should come first
set -xg PATH /usr/local/bin:/usr/local/sbin $PATH


set -xg PKG_CONFIG_PATH $PKG_CONFIG_PATH /usr/local/Cellar/sqlite/3.8.4.3/lib/pkgconfig
set -xg PKG_CONFIG_PATH /usr/local/Cellar/qt5/5.1.0/lib/pkgconfig/ $PKG_CONFIG_PATH


set -xg PATH "$HOME/bin" "/usr/local/bin" $PATH

if test -d "$HOME/gocode/bin"
  set -xg PATH "$HOME/gocode/bin" $PATH
end

if test -d "/usr/local/sbin"
  set -xg PATH $PATH "/usr/local/sbin"
end

if test -d "/usr/local/heroku/bin"
  set -xg PATH $PATH "/usr/local/heroku/bin"
end

set -xg EDITOR "vim"
set -xg BUNDLE_EDITOR "mvim"
set -xg NODE_PATH "/usr/local/lib/node" $NODE_PATH
set -xg GOPATH "$HOME/gocode" $GOPATH
set -xg IM_ALREADY_PRO_THANKS "conceited bastard"
set -xg PAGER "less"
set -xg LINEMAN_AUTO_START false
alias vi vim

set --local host_spec $HOME/dotfiles/fish/(hostname -s)_spec.fish

set fish_greeting ""

if test -f "$host_spec"
  . $host_spec
end
