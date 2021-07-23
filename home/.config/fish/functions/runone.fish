function runone --argument vs ds
    source ~/Desktop/ftr/functions/ftr.fish 
    printf 'verbose should: %s debug should: %s' $vs $ds
    
    set -l va (printf '%s %s' (if-verbose printf print) (printf $status))
    if test "$va" = "$vs"
        set_color green
        set vr 'pass'
    else
        set vr 'fail'
        set_color red
    end
    printf 'verbose: %s\n\texpected: %s\n\treceived: %s\n' $vr $vs $va
    set_color normal
    echo
end
