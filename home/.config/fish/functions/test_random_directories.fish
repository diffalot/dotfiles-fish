function test_random_directories
argparse --min-args 2 d/depth f/files_per_directory -- $argv
or return

for how_deep in (seq 1 $depth)
set num_to_go math $depth - $how_deep
set -l dirname (random)
mkdir $dirname
cd $dirname
test_random_files $files
if $num_to_go -ge '0'
test_random_directories -f $files \
--depth $num_to_go
end 
cd ..

end 
tre
end
