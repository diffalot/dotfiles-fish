#!/usr/bin/env fish

# Changed this after lifting it from SO because I'm not ready to not know if the string builtins are misbehaving or if my code is fucking them up.
# https://stackoverflow.com/a/52798873/10377319
# NOTE: now that I've played with it a bit, I'm thinking that the switch order should be reversed so that the you won't get false positives
# Like run the pattern check for each of these starting with integer and binary and get back a list of all the things the string could be???
# then make a simpler version that gets the list and resolves by glancing through it...
function string_is --description "string_is <type> <string under test>"
    if set -q argv[1]
        echo looking for $argv[1]
        set -l pattern
        switch $argv[1]
            case int integer
                set pattern '^[+-]?\d+$'
            case hex hexadecimal xdigit
                set pattern '^[[:xdigit:]]+$'
            case oct octal
                set pattern '^[0-7]+$'
            case bin binary
                set pattern '^[01]+$'
            case float double
                set pattern '^[+-]?(?:\d+(\.\d+)?|\.\d+)$'
            case alpha
                set pattern '^[[:alpha:]]+$'
            case alnum
                set pattern '^[[:alnum:]]+$'
            case '*'
                echo "unknown class..." >&2
                return
        end
        string match --quiet --regex -- $pattern $argv[2]
    end
end


# random, useless, and cool

function color_check
    color_blast $argv
end

function color_blast
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
