#!/usr/bin/env fish

function cab -a level show_vars
    # Helpers
    function get_level_index_for -a level_name
        for level in $_cab_level_names
            if contains $level_name $level
                printf '%i' (contains --index $level_name $level)
            end
        end
        return -1
    end

    function get_color_args_for -a level_index
        if $level_index -gt 0
            printf $_cab_level_fonts[$level_index]
        end
    end

    set -l first_message 2
    switch $show_vars
        case show_vars show vars
        set first_message 3
        set show_vars true
    end

    for i in (seq $first_message (count $argv))
        if not test "$_cab_ready" = 'true'
            printf "%s\n" $argv[$i]
        else
            set -l level_index (get_level_index_for $level)
            eval set_color (get_color_args_for $level_index || printf "%s\n" "red --bold")
            printf "%s\n"
        end
    end

    if test $show_vars = 'true'
        for i in (seq 1 (count $argv))
            set -S $argv[i]
        end
    end
end

function _cab_reset
    set -e -g _cab_ready
    set -e -g _cab_display_less_than
    set -e -g _cab_level_definitions
    _cab_setup
end

function _cab_setup
    set -g _cab_ready false
    if not set -q _cab_display_less_than
        set -g _cab_display_less_than 2
    end

    if not set -q _cab_level_definitions
        set -g _cab_level_definitions error:fail%brred:black:bold:italic \
                             warn:DANGER:please:well%bryellow:black:italic \
                             info:NOTE:ok%brblue \
                             debug:oof:%brgreen:inverse:blue \
                             trace:well%cyan
    end

    set -g _cab_possible_flags bold dim italics reverse underline
    set -g _cab_possible_colors (set_color --print-colors)

    _cab_cache; and set _cab_ready true
end





function is_valid_color -a input
    if contains $input $_cab_possible_colors
        return 0
    end
    return 1
end

function is_valid_flag -a input
    if contains $input $_cab_possible_flags
        return 0
    end
    return 1
end

function build_level_font -a font_colors_and_attributes
    # only add attributes that are valid
    set -l set_color_args
    set -l have_set_foreground_color = false

    for attribute in $font_colors_and_attributes
        if test (is_valid_color $attribute) -eq "0"
            if test $have_set_foreground_color = false
                set -a set_color_args $attribute
                set have_set_foreground_color true
            else
                set -a set_color_args (string join '' '--background ' $attribute)
            end
        end
        if test (is_valid_flag $attribute) -eq 0
            set -a set_color_args (string join '' '--' $attribute)
        end
    end
    echo $set_color_args
end

function _cab_cache

    #helper functions only used during cache construction, and cache construction is really only needed once...

    function is_integer -a number
        if string match --quiet --regex -- '^[+-]?\d+$' $pattern
            return 0
        end
        return 1
    end

    function level_number_for_name_from_list -a name
        set -l most_recent_level
        for maybe_name in $_cab_all_names
            if test "$name" = "$maybe_name"
                printf %i $most_recent_level
                return 0
            end
            is_integer $maybe_name; and set most_recent_level $maybe_name
        end
        return 1
    end

    function level_name_from_list_for -a name
        echo _cab_level_names[(level_number_for_name_from_list $name)][1]
    end

    function clean_up_globals
        if test _cab_ready != "true"
        set -l builders build_level_names build_level_fonts
        set -l helpers is_integer level_number_for_name_from_list \
            level_name_from_list_for clean_up_globals
        end
    end

    # builder functions for cache construction

    function build_level_names -a names_list

        # ⇸ ⤉ ⤈ ⇹ ⇺ ⇻ ⇞ ⇟ ⇼ ⬴ ⤀ ⬵ ⤁ ⬹ ⤔ ⬺ ⤕ ⬻ ⤖ ⬼ ⤗ ⬽ ⤘ ↞ ↠ ↟ ↡ ↯ ☈ ⥼ + − ± ∓ ÷ ∗ ∙ × ⨊ ⅀ ∏ ∐ ∔ ∸ ≂ ⊕ ⊖ ⊗
        # I never said it was _only_ names      | 04   | DarkBlue | (should be replaced) ⊘ ⊙ ⊚ ⊛ ⊝ ⊞ ⊟ ⊠
        # and I might build it this way too     = '#8308ff',"" --| 05 | DarkMagenta | Cursor⊡ ⋄ ⋇ ⋆ ⋋ ⋌ ~
        # as a oh no, the environments fucked   = '#069a93', --| 06   | DarkCyan    |⩱ ⩲ Δ ∀ ∞ ∃ ∄ | ∤ ‱
        # and I need a way off the planet sort  = '#63746e', --| 07   | LightGrey?  | ∇ ∘ ∻ ∽ ∾ ∿ ≀ ≁ ≬ ⊏
        # of plan which naturally begins with   | Grey?       |⊐ ⊑ ⊒ ⋢ ⋣ ⊓ ⊔ ⊶ ⊷ ⊸ ⊹ ⊺ ⋈ ⋉ ⋊ ⋮ ⋯ ⋰ ⋱ ⌈ ⌉
        # a logger for the fish shell.          | Red         | ⌊ ⌋ 〈 〉 ⊲ ⊳ ⊴ ⊵ ⋪ ⋫ ⋬ ⋭ ≠ ≈ ≂ ≃ ≄ ⋍ ≅ ≆
        set -a _cab_all_names "$i" # ≪ ≫ ≮ ≯ ≰  | Green       |≇ ≉ ≊ ≋ ≌ ≍ ≎ ≏ ≐ ≑ ≒ ≓ ≔ ≕ ≖ ≗ ≙ ≚ ≜ ≟ ≡
        # ≵ ≶ ≷ ≸ ≹ ≺ ≻ ≼ ≽ ≾ ≿ ⊀ ⊁ ⊰ ⋖ ⋗ ⋘ ⋙ ⋚ | Yellow      | CursorText≢ ≭ ⋕ ⁰ ¹ ² ³ ⁴ ⁵ ⁶ ⁷ ⁸ ⁹ ⁺ ⁻ ⁼
        #  ⋟ ⋠ ⋡ ⋦ ⋧ ⋨ ⋩ ∫ ∬ ∭ ∮ ∯ ∰ ∱ ∲ ∳ ⨌ ⨍ ⨎ ⨏ ⨐ ⨑ ⨒ ⨓ ⨔ ⨕ ⨖ ⨗ ⨘ ⨙ ⨚ ⨛ ⨜ ⌀ ∠ ∡ ∢ ⦛ ⦜ ⦝ ⦞ ⦟ ⦠ ⦡ ⦢ ⦣ °

        set -l level_names

        for name in $names_list

            if contains $name $_cab_all_names
                cab warn "Names can only be used on a single level; $name will not be available on level $i. It has already been used in `" (level_name_from_list_for $name) "`."
            else
                set -a _cab_all_names $name
                set -a level_names $name
            end
        end
        echo $names_list
    end

    # Pre-validation
    set -l total_to_cache (count $_cab_level_definitions)

    if test $total_to_cache -ne 5
        set_color brred --bold
        echo You must have at least five levels for logging.
        echo You currently have "$total_to_cache" levels defined in \$_cab_level_definitions
        set_color brred --italic
        set -S _cab_level_definitons
        set_color normal
        return 1
    end

    # Cache Clearing
    set -g _cab_all_names
    set -g _cab_level_names
    set -g _cab_level_fonts

    for i in (seq 1 $total_to_cache)

        set -l level_settings $_cab_level_definitions[$i]

        set -l level_settings_names_and_font (string split % $level_settings)

        set -l level_setting_names_list (string split : $level_settings_names_and_font[1])
        set -l level_names (build_level_names $level_setting_names_list)

        set -l level_setting_font_colors_and_attributes  (string split : $level_settings_names_and_font[2])
        set -l level_font (build_level_fonts $level_setting_font_colors_and_attributes)

        # add names and fonts to the appropriate arrays
        set -a _cab_level_names $level_names
        set -a _cab_level_fonts $level_font 

        # we rely on the index of the log level name given in scripts to find
        # the associated font, so we check that we're on track to have that
        # after each level setting is processed to make finding bugs easier
        # for everyone.
        set -l recorded_names $_cab_names[(count $_cab_level_names)]
        set -l recorded_font  $_cab_fonts[(count $_cab_level_fonts)]
        # INFO these are light checks that can be toughened up if necessary
        #if test (test (string join ':' "$recorded_names") != $level_setting_names_list)
        #    -o (test string match \
        #        (string split : level_setting_font_colors_and_attributes)[1] \
        #        "$recorded_font"
        #    )
            _cab_debug (string escape (set -l))
            return 1
    #end

    end

    # Post-validation
    set -l total_cached_names (count $_cached_names)
    set -l total_cached_fonts (count $_cached_fonts)

    if test $total_cached_names -ne $total_cached_fonts
        set_color brred --bold
        echo We wound up with $total_cached_names levels and $total_cached_fonts fonts and we were looking for $to_setup
        set_color brred --italic
        set -S _cab_names
        set_color normal
        set_color brred --bold
        set_color normal
        return 1
    end
end

function _cab_emergency_debug
    echo
    set_color bryellow --background black --italic
    echo '============================================================='
    echo full debug info
    echo
    status
    echo
    status stack-trace
    echo
    set_color brred --bold
    for var in (set -g | grep '_cab_')
        echo $var
    end
    set_color brred --italic
    echo
    for arg in $argv
        echo (string unescape $arg)
    end
    echo
    echo '============================================================='
    set_color normal
end
