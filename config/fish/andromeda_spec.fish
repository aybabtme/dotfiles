set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
set -gx HUMANLOG_INSTALL ""
set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
set -q PATH; or set PATH ''; set -gx PATH "$HOME/.ps-toolbox/bin" $PATH;
set -q PATH; or set PATH ''; set -gx PATH "$HOME/.nvm" $PATH;
set -q PATH; or set PATH ''; set -gx PATH "$HOME/.humanlog/bin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

function log
  echo $argv 1>&2
end

function tailscale
	/Applications/Tailscale.app/Contents/MacOS/Tailscale $argv
end

function select-turtle
	pskube --list | fzf > ~/.planetscale/current-turtle
end

function unselect-turtle
  rm ~/.planetscale/current-turtle
end

function get-turtle
	# if current turtle is empty, first call select turtle
  if not test -e ~/.planetscale/current-turtle
    select-turtle
  end
	cat < ~/.planetscale/current-turtle
end

function pk -d "Call `pskube` with the current turtle"
  log "<turtle: $(get-turtle), namespace: default>"
  pskube (get-turtle) $argv
end

function pkud -d "Call `pskube` with the current turtle, in the user-data namespace"
  log "<turtle: $(get-turtle), namespace: user-data>"
  pskube (get-turtle) $argv --namespace user-data
end

function clean-turtle -d "Clean up dev turtle"
  log "cleaning $(get-turtle)"
  pk delete psc --all --namespace user-data
  pk delete bt --all --namespace user-data
  pk delete vbj --all --namespace user-data
  echo ""
end

function psop-logs
	pk logs -l app=psdb-operator -f | humanlog --truncate=false
end 

function show-pods -d "Show all pods for a given branch"
  pk -n user-data get pods  -L psdb.co/tablet-type -L psdb.co/cell -L psdb.co/cluster -L psdb.co/cluster-type -L psdb.co/shard -L psdb.co/keyspace -L psdb.co/size
end

source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
