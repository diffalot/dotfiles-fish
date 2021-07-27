function oracle
if test -z "$argv"
cat ~/cronofiles/oracle | sort --reverse | bat -
return $status
end
echo $argv >> ~/cronofiles/oracle 
set r (random-int 2)
if test (random-int 2) -eq 1
echo yes
else
echo no
end
end
