function test-random-int --argument tests min max
set -l _test_random_results
for i in (seq 1 $tests)
set r (random-int $min $max)
printf "%s " $r
set _test_random_results[$r] (math $_test_random_results[$r] + 1)
if test $i -eq $tests
echo
set -S _test_random_results
end
end
end
