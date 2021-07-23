function test_random_edits --argument num
set -l all_files (find ./ | sort -R)
set -l num_files (count $all_files) 
if test $num_files -gt 5 
read "are you sure you want to edit " answer
if test $num -gt $num_files
echo you can only edit each of these $num_files files once.
#exit 1
end
for x in (seq 1 $num)
set -l
printf '%i %s' $x 3
#printf %s "echo (random) > $all_files[$x]"
end
end

end
