function pipe-pad-with-color --argument color
while read -l line
# TODO: make this check line lenght and round up padding to nearest 
#     (((line_length modulo full_screen_width) + 1) * screen_width)
set pad_length $COLUMNS
set line_length (string length $line)
if test $line_length -gt $pad_length
set pad_length (math "$COLUMNS * (1 + floor $line_length / $COLUMNS)")
end
eval set_color $color
printf %s\n (string pad -c \U00A0 --right --width $pad_length $line)
set_color normal
end
end
