function _mdiff_word_matches_these_globs --description 'Run `string match {glob} word` for each glob.  Collect and print the matches.' --argument word
set -l matches
for glob in $argv
if string match $glob $word
set -a matches $glob
end
end
for glob in $matches
printf %s $glob
end
if test "0" = "$debug"
set -l
end
end
