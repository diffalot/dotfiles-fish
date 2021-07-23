function test_random_files --argument num
if test $num -le 0
set num 5
end
for x in (seq 1 $num)
touch (random) 
end
end
