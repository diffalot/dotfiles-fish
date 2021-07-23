#!/usr/bin/env fish

# _target_exists
# _target_is_a_function
#
# CHECK: needs testing
function is_debug_mode -a debug \
   -d "returns true \$debug is 1 or the \$_ftr_debug environment variable is 1"
   return test ($debug -o $_ftr_debug)
end

function _ftr_gives_human_report
   return 0
end

function _ftr_is_a_number -a var
   if test (var -ge 0 -o var -lt 0)
      printf %i 0
   else
      printf %i 1
   end
end

function _ftr_indent -a padding
   set -S padding
   set -l spaces 'sed s/^/'
   for n in (seq 1 padding)
      set -a spaces " "
   end
   set -a spaces '/'

   set_color red
   echo spaces $spaces
   set_color normal

   set -l s1d (string join '' $spaces)

   echo
   set_color red
   echo sed $s1d
   set_color normal
   echo
   while read $line
      printf '%b\n' (eval $s1d $line)
   end
end

function _ftr_source_directory --argument-names directory # full_tree_find regex
    # set -l $maxdepth # TODO: accept these arguments
    # set -l $regex_string
    if test "$debug" = 'true'
    end

    echo
    echo running "find $directory -maxdepth 1 -regex '.*\.fish\$' | sort"
    set -l found_files (find $directory -maxdepth 1 -regex '.*\.fish' | sort)
    echo "And now sourcing"
    for file in $found_files
        echo '    ' sourcing: $file
        source $file
        if test $status -ne 0
            set_color bryellow --background black
            echo You should fix that and then try again.
        end
    end
end

#function flagged_help

# DOCS: all user-facing-functions should check their arguments and fail gracefully because _internal_functions should fail hard and exit with a stack trace
function ftr-source-plugin-directory --description "
- Sources all `*.fish` files in <directory>/{conf.d|functions|completions} if they exist.
- If no directory is provided, the current directory is assumed.
" \
    --argument-names target_directory

    set -l usage "ftr-source-plugin-directory <directory>"
    # if _help_flagged $argv
    if test -z $directory
        set target_directory (pwd)
    end
    set -l sourced_directories
    for directory in conf.d functions completions
        if test -d $directory
            #_ftr_source_directory $target_directory/$directory
            if test $status -eq 0
                set -a sourced_directories $directory
            end
        end
    end
    set -e -l directory
    if test (count sourced_directories) -eq 0
        set_color yellow --bold
        echo "No `completions`, `conf.d`, or `functions` directories were found in `$target_directory` so nothing was sourced"
        set_color normal
    end
    status
    status filename
    set -l
end
