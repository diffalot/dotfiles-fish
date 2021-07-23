function is_macOS_dark_mode
if test (defaults read -g AppleInterfaceStyle) = 'Dark'
return 0
end
return 1
end
