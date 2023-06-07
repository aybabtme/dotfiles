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

function tailscale
	/Applications/Tailscale.app/Contents/MacOS/Tailscale $argv
end

source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"
