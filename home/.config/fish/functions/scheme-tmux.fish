#!/usr/bin/env fish
function scheme-tmux -a scheme

    # don't override these unless you are very careful about it
    set -l info green
    set -l warn yellow
    set -l error red
    
    # Set defaults
    set -l darkest colour234	
    set -l lightest colour240
    set -l grayest colour234 
    set -l highlight cadetblue
    set -l counterpoint '#6a5acd'	# slateblue
    
    switch $scheme
        case 'day'
            echo using $scheme scheme
            set darkest colour250
            set lightest colour242
            set grayest colour238      
            set counterpoint '#5f9ea0' 	# cadetblue
            set highlight '#2e8b57' 	# darkslateblue
        case '*'
            echo 'no scheme set, using defaults'
    end
    
    # Copied from .tmux.config edited by hand
    tmux set -g status-bg $darkest
    tmux set -g status-fg $lightest

    tmux set-window-option -g window-status-style fg=$lightest
    tmux set-window-option -g window-status-activity-style fg=$warn,blink
    tmux set-window-option -g window-status-current-style fg=$highlight
    
    tmux set -g mode-style bg=$counterpoint,fg=$darkest
    
    tmux set -g pane-border-style fg=$grayest
    tmux set -g pane-active-border-style fg=$highlight

    tmux set -g message-style bg=$lightest,fg=$darkest
    tmux set -g message-command-style bg=$lightest,fg=$darkest

    # status left
    tmux set -g status-left "#{?client_prefix,#[fg=$highlight]#[bg=$grayest],} #{simple_git_status} ⁂ #S ❱ #[default]"

    # the backround color of the right status is controlled by cpu temp
    # the text colour is the default green to yellow to red as ram fills
    tmux set -g @cpu_low_bg_color "#[bg=default]" # background color when cpu is low
    tmux set -g @cpu_medium_bg_color "#[bg=$darkest,$greyest]" # background color when cpu is medium
    tmux set -g @cpu_high_bg_color "#[bg=$darkest,$greyest]" # background color when cpu is high
    tmux set -g @ram_low_fg_color "#[fg=$darkest,$greyest]" # background color when cpu is low
    tmux set -g @ram_medium_fg_color "#[fg=$darkest,$greyest]" # background color when ram is medium
    
    # status right
    # TODO: Turn the right status back on
    tmux set -g status-right '#{ram_fg_color}#{cpu_bg_color} %Hh #{cpu_percentage} #{ram_percentage} '

    # end copied shit
end

