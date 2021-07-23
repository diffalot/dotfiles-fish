function is_dark_mode
if is_macOS_dark_mode 
return 0
end
if ! test (test (date +%k) -ge 7) -a (test (date +%k) -le 19)
return 0
end
return 1
end
