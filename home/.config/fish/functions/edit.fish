function edit --description 'run in a session, if not for this directory then for alice'
set -l session (basename (pwd))
set -l kak_sessions (kak -l)
if not contains $session $kak_sessions
if not contains $USER $kak_sessions
set session $USER
end
echo starting kak -d -s $session
kak -d -s $session &
end
kak -c $session $argv
end
