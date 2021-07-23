function tmux-show_location
if test -z $TMUX
return 0
end
set -l session (tmux list-sessions | grep attached | awk '{printf $1}') | sed -r 's/\://'
set -l window (tmux list-windows | grep active | awk '{printf $1}' | sed -r 's/\://')
set -l pane (tmux list-panes | grep active | awk '{printf $1}' | sed -r 's/\://')
printf '%s %s.%s' $session $window $pane
end
