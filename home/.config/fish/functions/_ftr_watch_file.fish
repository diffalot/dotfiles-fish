 function test-fish-file -a file
     set -l onchange_is_fun (command --query onchange)
     if test -n (command --query onchange)
         if test -n "$file" # TODO: if string is nonzero and if file exists
             set -l test_file (-find-test-file $file)
             if test -n "$test_file"
                 
             else
                 echo "$test_file not found"
             end
         else
             echo couldn\'t do anything, no file provided
         end
     else
	 echo please install `onchange` globally from npm or yarn
     end
 end
     
#onchange -k --initial "./functions/**/*.fish" "./tests/**/*.fish"  -- tests/session-kak.test.fish
# TODO:
# - offer to template test and file if it doesn't exist
# - search for file with find in current project
