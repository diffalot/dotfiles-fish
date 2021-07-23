# Defined interactively
function fish_colors --argument cmd
    switch $cmd
        case drop
        set color_vars (set --names | grep fish_color)
        for color_var in $color_vars
            printf "%-30s %s\n" \
            $color_var \
            (set_color $$color_var --reverse)"$$color_var"(set_color normal)
        end
    end
end
