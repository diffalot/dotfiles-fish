function tmux-shows_status
not tmux-is_in_tmux; and return 1
if test (tmux show-options status) = 'status on'
return 0
end
return 1
end
