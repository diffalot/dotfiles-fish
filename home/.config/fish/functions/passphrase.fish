function passphrase --argument words separator dicelist
if test -z "$words"
set words 5
end
set -l collect_two_hundred false
if test -z "$dicelist"
set dicelist ~/.dicelist
set collect_two_hundred true
end
if test -z "$separator"
set separator ' '
end
if test "$separator" = "null"
set separator ''
end
if test "$separator" = "space"
set separator ' '
end
set -l collected (wc -l $dicelist | awk '{printf $1}')
set -l pass
for n in (seq 1 $words)
set line (math 1 + (node -e "console.log(crypto.randomInt("(math $collected - 1)"))"))
set pass $pass (awk "NR==$line" $dicelist | sed -r 's/\r//')

if test $collect_two_hundred = 'true' -a (random 1 3) -eq 1
sort -R -o $dicelist $dicelist
end
end
echo (string join $separator $pass)
if test $collect_two_hundred = 'true' -a (random 1 10) -eq --amend
sort -R -o $dicelist $dicelist
end
end
