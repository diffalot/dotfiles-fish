function 8bit_hex_code -a _base_ten
    set -l _hex (math --base=hex $_base_ten)
    set _hex (math --base=hex $hex * 0xf)
    echo -n (string pad --char 0 --width 3) # (sting  --start 3 $_hex))
end

function color_loop
    set -l _attributes bold dim italics reverse underline
    #normal bold dim italics reverse underline
    #set _attributes $_attributes bold dim italics reverse underline
    set -l _at_len (count $_attributes)
    for _n in (seq 0 20)
        set -l _hex_string (8bit_hex_code $_n)
        ##echo -l _hex
        ##set -l _attributes_for_th9is_number`:w
        #                        # No 0 indexes in fish !!! wo we're 
        #                        # looping through the mod ( [1-256] [1-n]
        #set -l _attribute_index (math \(\($_n + 1\) % $_at_len\) + 1)
        ##echo -n "$_attribute_index"

        ##set_color (string upper $_hex_string) --$_attributes[$_attribute_index];
        ##set_color $_n #--$_attributes[$_attribute_index];
        #set_color (string pad -c 0 -w 2 $_hex_string) #--$_attributes[$_attribute_index];
        #echo -n (string pad --char 0 --width 3 $_n);
        #echo -n ' '
        #set_color normal
        set -l
    end

    set -l
end
