function tmux-is_in_sessions
not tmux-is_in_tmux; and return 1
if contains (tmux display-message -p '#S') $argv
return 0
end
return 1
end
