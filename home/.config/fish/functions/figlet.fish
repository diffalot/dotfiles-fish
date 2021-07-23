function figlet
if contains '\-f' $argv
command figlet $argv
else
set -l possibilities 'standard' $figlet_favorites
set -l selected (random choice $possibilities)
printf %s\n\n " >_ figlet -f '$selected' $argv"
command figlet -f "$selected" $argv
end
end
