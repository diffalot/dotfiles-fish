function switch-nvim --argument to_this_one

    set original_dir (pwd)

    if test (count (ps aux | grep nvim | grep -v grep | grep -v tmux)) -gt 0
        set_color brred --background=black --bold
        printf '∿%.s' (seq 1 (tput cols))
        echo
        echo
        printf "    Looks like nvim is still running somewhere...\n\n    Turn it off and we'll"
        set_color normal
        set_color --italic brred --background=black
        printf "\n\n             Deploy The Hack!\n"
        echo
        printf '∿%.s' (seq 1 (tput cols))
        echo
        echo
        echo ">_ ps aux | grep nvim | grep -v grep | grep -v tmux"
        # TODO: come back when full width font generators are working and put this back with the black block
        ps aux | grep nvim | grep -v grep | grep -v tmux | pipe-pad-with-color "--background=black"
        set_color brred --background=black --bold
        echo
        printf '∿%.s' (seq 1 (tput cols))
        echo
        echo
        set_color normal
        return 1
    end

    function rm_and_replace_link -a dirloc linkloc target_suffix
        cd $dirloc
        if not test -L $linkloc
            echo $linkloc is not a link, stopping
            return 1
        end

        set -l target $linkloc-$target_suffix
        if not test -e $target
            echo $target does not exist, stopping
            return 1
        end

        # echo $linkloc is a link to (readlink $linkloc), removing and making link to $target
        rm $linkloc
        ln -s $target $linkloc
        echo $linkloc now linking to (readlink $linkloc)
        cd -
    end

    function do_replacement -a to_this_one
        rm_and_replace_link ~/.config nvim $to_this_one
        rm_and_replace_link ~/.local/share nvim $to_this_one
    end

    set -l nvims (fd --max-depth 1 '.*nvim-[a-z]*' ~/.config | sed -r 's:'$HOME'/.config/nvim-::')
    breakpoint

    if contains $to_this_one $nvims
        do_replacement $to_this_one
    else
        set to_this_one (printf '%s\n' $nvims| fzf)
        if contains $to_this_one $nvims
            do_replacement $to_this_one
        end
    end
end


# FIXME changes directory to config/nvim-base (previous? `cd -` ) after linking? running?
# FIXME don't switch .loc/.../nvim/site, use .loc/.../nvim
