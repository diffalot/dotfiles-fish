function session-kak
    set -l session (basename (pwd))
    set kak_sessions (kak -l)
    set -S session
    set -S kak_sessions

    if contains $session $kak_sessions
        echo joining $session
        kak -c $session $argv
    else
        echo starting $session
        kak -s $session $argv
    end

    set -l
end
