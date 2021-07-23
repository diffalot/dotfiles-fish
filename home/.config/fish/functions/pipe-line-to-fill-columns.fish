function pipe-line-to-fill-columns
while read -l line
printf %s\n (string pad -c \U00A0 --right --width $COLUMNS $line)
end
end
