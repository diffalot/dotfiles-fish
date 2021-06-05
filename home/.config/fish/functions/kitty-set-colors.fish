#!/usr/bin/env fish

function color_check
    if tput cols > 99
        crunchbang;
    end
    if tput cols > 55
        crunchbang-mini;
        colorview;
        crunchbang;
        color-support;
        alpha;
    end
    if tput cols > 99
        hex-block;
        colortest; 
        crunchbang;
    end
    colorwheel
end

# TODO: try this out it looks neat
# https://unix.stackexchange.com/a/203847/162483
function _or_default
    set -q $argv[1]; and echo $$argv[1]; or echo $argv[2]
end
function _kitty_socket
    echo (ls /tmp/theKitty-*)
end

function ksf -a file -d "Kitty Set File - sets a file as the color scheme"
    kitty @ --to unix:(_kitty_socket) set-colors -- $file
end

function kitty-set-colors
    if test "$argv" = "save" && test -n "$_kitty_last_loaded_theme"
        and echo removing active link to (readlink $HOME/.config/kitty/theme.conf);
        ln -fs $_kitty_last_loaded_theme $HOME/.config/kitty/theme.conf;
        and echo (basename $_kitty_last_loaded_theme .conf) linked as default;
        and set -e _kitty_last_loaded_theme;
    else

        set -l maybe_query

        if test -n "$argv"
          set maybe_query \-\-query $argv
        end
        set -l theme (find "$HOME/.config/kitty/kitty-themes/themes" \
              "$HOME/.config/kitty/base16-kitty/colors" \
              "$HOME/Desktop/colors/iTerm2-Color-Schemes/kitty" \
              -type f | fzf --reverse --delimiter / --with-nth -1 \
              --bind "?:toggle-preview" --preview 'echo {}' \
              --preview-window hidden:up:wrap $maybe_query)

        ksf $theme

        color_check

        set_color --italics;
        echo -n "set theme to ";
        set_color --bold 00ffcc;
        set -l _human_name (basename $theme ".conf")
        echo -n $_human_name;
        set_color --italics normal;
        echo " from ";
        set_color --dim --italics;

        set -l _t_length    (string length $theme)
        set -l _s_columns   (tput cols)

        if test $_t_length -gt $_s_columns
            echo (string sub --start (math $_t_length - $_s_columns + 1) $theme)
        else
            echo $theme
            #echo (string pad --width $_s_columns $theme)
        end

        set -U _kitty_last_loaded_theme $theme

    end

end


