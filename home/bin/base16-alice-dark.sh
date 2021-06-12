#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Default Dark scheme by Chris Kempson (http://chriskempson.com)
                                                   #    What?
#color00="00/00/00" #- Black         00               # Base 00?
#color01="80/00/00" #- Dark Red      01               # Base 08?
#color02="00/80/00" #- Dark Green    02               # Base 0B?
#color03="80/80/00" #- Dark Yellow   03               # Base 0A?
#color04="00/00/80" #- Dark Blue     04               # Base 0D?
#color05="80/00/80" #- Dark Magenta  05               # Base 0E?
#color06="00/80/80" #- Dark Cyan     06               # Base 0C?
#color07="c0/c0/c0" #- Dark White    07               # Base 05?
#color08="80/80/80" #- Light Black   08               # Base 03?
#color09="ff/00/00" #- Red           09               # Base 08?
#color10="00/ff/00" #- Green         10               # Base 0B?
#color11="ff/ff/00" #- Yellow        11               # Base 0A?
#color12="00/00/ff" #- Blue          12               # Base 0D?
#color13="ff/00/ff" #- Magenta       13               # Base 0E?
#color14="00/ff/ff" #- Cyan          14               # Base 0C?
#color15="ff/ff/ff" #- White         15               # Base 0C?
#color16="00/00/00" #- Grey0         16               # Base 09?
#color17="a1/69/46" #-               17               # Base 0F?
#color18="28/28/28" #-               18               # Base 01?
#color19="38/38/38" #-               19               # Base 02?
#color20="b8/b8/b8" #-               20               # Base 04?
#color21="e8/e8/e8" #-               21               # Base 06?
#color_foreground="e4/e4/e4"                        # Base 05
#color_background="18/28/28"                        # Base 00

# The numbers about to be crunched, "reference" numbers they replaced, and the numbers I got off a phone screenshot
color00="36/36/36" # Black          00 "#" 00/00/00                    #  # Section 1
color01="ff/08/83" # Dark Red       01 "#" 80/00/00                    #  COLOR_01="#363636"          # HOST
color02="83/ff/08" # Dark Green     02 "#" 00/80/00                    #  COLOR_02="#ff0883"          # SYNTAX_STRING
color03="ff/83/08" # Dark Yellow    03 "#" 80/80/00                    #  COLOR_03="#83ff08"          # COMMAND
color04="08/83/ff" # Dark Blue      04 "#" 00/00/80                    #  COLOR_04="#ff8308"          # COMMAND_COLOR2
color05="83/08/ff" # Dark Magenta   05 "#" 80/00/80                    #  COLOR_05="#0883ff"          # PATH
color06="08/ff/83" # Dark Cyan      06 "#" 00/80/80                    #  COLOR_06="#8308ff"          # SYNTAX_VAR
color07="b6/b6/b6" # Dark White     07 "#" c0/c0/c0                    #  COLOR_07="#08ff83"          # PROMP
color08="42/42/42" # Light Black    08 "#" 80/80/80                    #  COLOR_08="#b6b6b6"          #
color09="ff/1e/8e" # Red            09 "#" ff/00/00
color10="8e/ff/1e" # Green          10 "#" 00/ff/00                    #  # Section 2
color11="ff/8e/1e" # Yellow         11 "#" ff/ff/00                    #  COLOR_09="#424242"          #
color12="1e/8e/ff" # Blue           12 "#" 00/00/ff                    #  COLOR_10="#ff1e8e"          # COMMAND_ERROR
color13="8e/1e/ff" # Magenta        13 "#" ff/00/ff                    #  COLOR_11="#8eff1e"          # EXEC
color14="1e/ff/8e" # Cyan           14 "#" 00/ff/ff                    #  COLOR_12="#ff8e1e"          #
color15="c2/c2/c2" # White          15 "#" ff/ff/ff                    #  COLOR_13="#1e8eff"          # FOLDER
color16="00/00/00" # Grey0          16                                 #  COLOR_14="#8e1eff"          #
color17="a1/69/46" #                17                                 #  COLOR_15="#1eff8e"          #
color18="28/28/28" #                18                                 #  COLOR_16="#c2c2c2"          #
color19="38/38/38" #                19
color20="b8/b8/b8" #                20                                 #  # Section 3
color21="e8/e8/e8" #                21                                 #  BACKGROUND_COLOR="#0d1926"  # Background Color
color_foreground="b4/e1/fd"     #   05 "#"e4/e4/e4                     #  FOREGROUND_COLOR="#b4e1fd"  # Text
color_background="0d/19/26"     #   08 "#"18/18/18                     #  CURSOR_COLOR="$FOREGROUND_COLOR" # Cursors

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg d8d8d8 # foreground
  put_template_custom Ph 181818 # background
  put_template_custom Pi d8d8d8 # bold color
  put_template_custom Pj 383838 # selection color
  put_template_custom Pk d8d8d8 # selected text color
  put_template_custom Pl d8d8d8 # cursor
  put_template_custom Pm 181818 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi




cat << 'EOF' >> fish
# getting read for fzf and fish and fzf
set -l fish00 '#363636'
set -l fish01 '#ff0883'
set -l fish02 '#83ff08'
set -l fish03 '#ff8308'
set -l fish04 '#0883ff'
set -l fish05 '#8308ff'
set -l fish06 '#08ff83'
set -l fish07 '#b6b6b6'
set -l fish08 '#424242'
set -l fish09 '#ff1e8e'
set -l fish0A '#8eff1e'
set -l fish0B '#ff8e1e'
set -l fish0C '#1e8eff'
set -l fish0D '#8e1eff'
set -l fish0E '#1eff8e'
set -l fish0F '#c2c2c2'

set -l FZF_NON_COLOR_OPTS

for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
    if not string match -q -- "--color*" $arg
        set -a FZF_NON_COLOR_OPTS $arg
    end
end

set -U FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
" --color=bg+:$fish01,bg:$fish00,spinner:$fish0C,hl:$fish0D"\
" --color=fg:$fish04,header:$fish0D,info:$fish0A,pointer:$fish0C"\
" --color=marker:$fish0C,fg+:$fish06,prompt:$fish0A,hl+:$fish0D"

# set syntax highlighting colors
set -U fish_color_autosuggestion $fish02
set -U fish_color_cancel -r
set -U fish_color_command green #white
set -U fish_color_comment $fish02
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_end brblack #blue
set -U fish_color_error red
set -U fish_color_escape yellow #green
set -U fish_color_history_current --bold
set -U fish_color_host normal
set -U fish_color_match --background=brblue
set -U fish_color_normal normal
set -U fish_color_operator blue #green
set -U fish_color_param $fish04
set -U fish_color_quote yellow #brblack
set -U fish_color_redirection cyan
set -U fish_color_search_match bryellow --background=$fish02
set -U fish_color_selection white --bold --background=$fish02
set -U fish_color_status red
set -U fish_color_user brgreen
set -U fish_color_valid_path --underline
set -U fish_pager_color_completion normal
set -U fish_pager_color_description yellow --dim
set -U fish_pager_color_prefix white --bold #--underline
set -U fish_pager_color_progress brwhite --background=cyan


# COLOUR (base16)

# default statusbar colors
set-option -g status-style "fg=$fish04,bg=$fish01"

# default window title colors
set-window-option -g window-status-style "fg=$fish04,bg=default"

# active window title colors
set-window-option -g window-status-current-style "fg=$fish0A,bg=default"

# pane border
set-option -g pane-border-style "fg=$fish01"
set-option -g pane-active-border-style "fg=$fish02"

# message text
set-option -g message-style "fg=$fish05,bg=$fish01"

# pane number display
set-option -g display-panes-active-colour "$fish0B"
set-option -g display-panes-colour "$fish0A"

# clock
set-window-option -g clock-mode-colour "$fish0B"

# copy mode highligh
set-window-option -g mode-style "fg=$fish04,bg=$fish02"

# bell
set-window-option -g window-status-bell-style "fg=$fish01,bg=$fish08"
EOF

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
