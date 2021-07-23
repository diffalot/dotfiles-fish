#!/usr/bin/env fish

# CHECK: needs testing
function _is_debug_mode -a debug \
   -d "returns true \$debug is true or the \$_utils_debug environment variable is true"
   return test ($debug -o $_utils_debug)
end

# random, useless, and cool

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
