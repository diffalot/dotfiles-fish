function random-int --argument min max
if test -z "$max"
set max $min
set min ''
end
if test -z "$max"
set max 10
end
if test -z "$min"
set min 1
end
random (random)
random $min $max
#echo (math $min + (node -e "console.log(crypto.randomInt("$max"))"))
end
