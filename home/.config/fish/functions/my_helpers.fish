function kittySetColors -a name
  set -l socket (ls /tmp/theKitty-*)
  kitty @ --to unix:$socket set-colors -- "/Users/alice/.config/kitty/kitty-themes/themes/$name.conf"
  echo see theme previews at https://github.com/dexpota/kitty-themes
end
