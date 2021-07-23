function tmux-is_in_tmux
if set --query TMUX
return 0
end
return 1
end
