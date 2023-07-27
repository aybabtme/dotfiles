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
  set old_turtle ""
  if test -e ~/.planetscale/current-turtle
    cat ~/.planetscale/current-turtle | read old_turtle
  end

  pskube --list-completion | gum filter > ~/.planetscale/current-turtle
  cat ~/.planetscale/current-turtle | read new_turtle
  log "using turtle $new_turtle"

  if test -e ~/.planetscale/current-cluster; test "$old_turtle" != "$new_turtle"
    log "turtle changed from $old_turtle to $new_turtle, clearing cluster selection"
    unselect-cluster
  end

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

function ts-up-down
  tailscale down; and tailscale up
  sleep 0.1
end

function select-cluster
  pkud get psc -o json | jq  -r -c '.items[] | .metadata.labels' | gum filter > ~/.planetscale/current-cluster
  jq < ~/.planetscale/current-cluster '.["psdb.co/cluster"]' | read new_cluster
  echo ""
  log "using cluster $new_cluster"
end

function unselect-cluster
  if test -e ~/.planetscale/current-cluster
    rm ~/.planetscale/current-cluster
  end
end

function get-psid
  if not test -e ~/.planetscale/current-cluster
    select-cluster
  end
  jq < ~/.planetscale/current-cluster -r '.["psdb.co/cluster"]'
end

function pk -d "Call `pskube` with the current turtle"
  log "<turtle: $(get-turtle), namespace: default>"
  log pskube (get-turtle) $argv
  pskube (get-turtle) $argv
end

function pkud -d "Call `pskube` with the current turtle, in the user-data namespace"
  log "<turtle: $(get-turtle), namespace: user-data>"
  set new_argv
  set has_namespace 0
  for arg in $argv
    if [ "$arg" = "--" ]
      set -a new_argv --namespace user-data
      set has_namespace 1
    end
    set -a new_argv $arg
  end
  if [ $has_namespace = 0 ]
    set -a new_argv --namespace user-data
  end
  log pskube (get-turtle) $new_argv
  pskube (get-turtle) $new_argv
end

function pkcluster -d "Call `pskube` with the current turtle, in the user-data namespace, with a label filtering the current cluster"
  log "<turtle: $(get-turtle), namespace: user-data, cluster: $(get-psid)>"
  pkud $argv -l psdb.co/cluster=(get-psid) -L psdb.co/keyspace,psdb.co/shard,psdb.co/tablet-type,psdb.co/cell
end

function get-cluster-shell-vtctl
  get-psid
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
