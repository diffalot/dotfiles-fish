#!/usr/bin/env fish

function session-nvr
    set -l session (basename (pwd))
    set nvr_sessions (kak -l)
    set -S session
    set -S kak_sessions

    if contains $session $kak_sessions
        echo joining $session
        kak -c $session $argv
    else
        echo starting $session
        kak -s $session $argv
    end

    if test ( _ftr_debugging )
        set -l
        printf "%s finished"
    end
end
