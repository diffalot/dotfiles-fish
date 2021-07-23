#!/usr/bin/env fish


function start-journal
    tmux new-session -d -A -s journal
    sleep 1
    tmux send-keys -t journal.1 "tmux set status off" ENTER
    tmux send-keys -t journal.1 "nvim ~/cronofiles/journal/index.md" ENTER
end


