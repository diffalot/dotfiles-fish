function sekak --description fire\ op\ a\ new\ tmux\ and\ kak\ session\ or\ join\ if\ it\'s\ already\ there
set -l session (basename (pwd))
set_color yellow
if not contains $session (kak -l)
echo starting kak session $session
kak -d -s $session \
&
else
echo joining kak session $session
end
if not contains $session (tmux ls | awk -F '[:]' '{ print $1 }')
echo booting tmux session $session
tmux new-session -d -A -s $session
end
if not test -n $TMUX and contains $session (tmux ls | awk -F '[:]' '{ print $1 }')
echo attaching to tmux session $session
tmux attach -t $session
end
end
