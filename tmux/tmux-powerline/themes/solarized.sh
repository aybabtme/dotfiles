#!/bin/bash
# Solarized Theme
# Attempting to copy: http://ethanschoonover.com/solarized
# Example: http://i.imgur.com/T9BTRG4.png

export TMUX_POWERLINE_SEG_WEATHER_LOCATION="2488836"
if patched_font_in_use; then
  TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="⮂"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="⮃"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="⮀"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="⮁"
else
	TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="◀"
	TMUX_POWERLINE_SEPARATOR_LEFT_THIN="❮"
	TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="▶"
	TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="❯"
fi

TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR:-'0'}
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR=${TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR:-'0'}

TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_LEFTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}
TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR=${TMUX_POWERLINE_DEFAULT_RIGHTSIDE_SEPARATOR:-$TMUX_POWERLINE_SEPARATOR_LEFT_THIN}

#background tones
DEFBG="0"
BASE03="234" #actually closer to 17, but 16 looks better
BASE02="235"
#content tones
BASE01="240"
BASE00="241"
BASE0="244"
BASE1="245"
#background tones
BASE2="254"
BASE3="230"

#accent colors
YELLOW="136"
ORANGE="166"
RED="160"
MAGENTA="125"
VIOLET="61"
BLUE="33"
CYAN="37"
GREEN="64"

WHITE="255"
GMAIL_RED="196"

# Format: segment_name background_color foreground_color [non_default_separator]

if [ -z $TMUX_POWERLINE_LEFT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		# "tmux_session_info ${DEFBG} ${YELLOW}" \
		"hostname ${DEFBG} ${ORANGE}" \
		#"ifstat 30 255" \
		#"ifstat_sys 30 255" \
		"lan_ip ${DEFBG} ${YELLOW} ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN}" \
		"wan_ip ${DEFBG} ${BLUE}" \
		"vcs_branch ${DEFBG} ${GREEN}" \
		#"vcs_compare ${DEFBG} ${BLUE}" \
    #"vcs_staged ${DEFBG} ${BLUE}" \
    #"vcs_modified ${DEFBG} ${BLUE}" \
		#"vcs_others ${DEFBG} 0" \
	)
fi

if [ -z $TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    #"earthquake 3 0" \
    "pwd ${DEFBG} ${GREEN}" \
		#"mailcount ${DEFBG} ${GMAIL_RED}" \
		#"now_playing 234 37" \
		"load ${DEFBG} ${YELLOW}" \
		#"tmux_mem_cpu_load 234 136" \
    "battery ${DEFBG} ${MAGENTA}" \
		"weather ${DEFBG} ${CYAN}" \
		#"xkb_layout 125 117" \
		#"date_day ${DEFBG} ${GREEN}" \
		#"date ${DEFBG} ${GREEN}" \
		"time ${DEFBG} ${ORANGE}" \
	)
fi
