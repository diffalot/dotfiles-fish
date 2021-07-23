#!/usr/bin/env fish

function pop-journal -a width height
    if test -z $width 
        set width "60%"
    end
    if test -z $height
        set height "40%"
    end
    if test "journal" != (tmux display-message -p -F "#{session_name}")
        tmux popup -xR -yS -w$width -h$height -EE "tmux new-session -d -A -s journal"
    else 
        tmux detach-client
    end

end


