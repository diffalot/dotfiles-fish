#!/usr/bin/env fish

function session -a requested_session

    argparse 'help' 'debug' -- $argv

    if test (is_debug_mode($debug))
        echo "(status -f) parsed arguments"
        set -S requested_session
        set -S debug
        set -S helped
        set -S argv
    end

    session-tmux
    session-nvr

    if test (is_debug_mode($debug))
        set -l
        printf "%s finished" (status -f)
    end

end
