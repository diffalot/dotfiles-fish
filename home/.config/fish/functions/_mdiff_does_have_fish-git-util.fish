# git utils provided by fishpkg/fish-git-util
#
# git_branch_name	Get the name of the current branch
# git_is_detached_head	Test if a repository is in a detached HEAD state
# git_is_dirty	Test if there are changes not staged for commit
# git_is_empty	Test if a repository is empty
# git_is_repo	Test if the current directory is a repository
# git_is_staged	Test if there are changes staged for commit
# git_is_stashed	Test if there are changes recorded in the stash
# git_is_tag	Test if a repository's HEAD points to a tag.
# git_is_touched	Test if there are changes in a repository working tree
# git_untracked_files	Get the number of untracked files in a repository
# git_ahead	Get a character that indicates if the current repo is in sync, ahead, behind or has diverged from its upstream. Default: '', '+', '-', '±'
# git_repository_root	Get the root directory of the current repository

set -l git_utils = git_branch_name \
                git_is_detached_head \
                git_is_dirty \
                git_is_empty \
                git_is_repo \
                git_is_staged \
                git_is_stashed \
                git_is_tag \
                git_is_touched \
                git_untracked_files \
                git_ahead \
                whatevers \
                git_repository_root

function _is_command -a cmd
    printf %i type -q $cmd
end

printf 'whatever %i' (_is_command git_ahead)

set -l missing
for util in $git_utils
    echo $util
    if not test (_is_commmand $util)
        set -a missing $util
    end
end

if test (count $missing) -gt 0
    set_color red --bold
    echo it looks like you are missing the following utilities provided by `fishpkg/fish-git-util`
    set_color normal
    set_color magenta
    echo $missing | sed 's/^/  - /'
    set_color normal
    set_color cyan --italic
    echo 'Please install the `fishpkg/fish-git-util` package via `fundle`, `fisher`, or the package management system of your choice:'
    echo '  - https://github.com/fishpkg/fish-git-util'
    echo '  - https://github.com/danhper/fundle'
    echo '  - https://github.com/jorgebucaran/fisher'
end

set -l
# black blue brblack brblue brcyan brgreen brmagenta brred brwhite bryellow cyan green magenta red white yellow
#
# -b, --background COLOR sets the background color.
#
#· -c, --print-colors prints a list of the 16 named colors.
#
#· -o, --bold sets bold mode.
#
#· -d, --dim sets dim mode.
#
#· -i, --italics sets italics mode.
#
#· -r, --reverse sets reverse mode.
#
#· -u, --underline sets underlined mode.
#
# provides default fonts 1-9 for success, default, error, coolfor themers to
# override responsibly

# manages local namespacing colission avoidance for libraries
# looks at the name of the calling function for / location and the a string
# between snake_case or kebab-case separators (the first is optional) ^[-|_]?.*[_|-]/
#
# she'll store 32 fonts in hex per namespace, and charge you only one color
# (where she will repurpose the space to store normal (if you do not have
# access to a normal, your font might get stuck...)
#
# 256 colors
#  16 fonts +
# 256 colors (all names map to 1 of the 256)
#
#   2 positions with colors (default, --background)
#
#   5 styles available now (will blink and curly-underline, strike, and/or dim)
#     be coming along soon, and how soon?
#
# normal means unset and unset it all
#
# needs to be future proof: "If people keep buying colors they're just going to
# keep making more."
#
# "trusts" functions from a config path lifestyle otherwise their details (location,
# prefix) are stored via a one way hash that is stored for 5 days for config
# file fun (automatically renewed during day 5, and 1 hour for ev, the timing
# can be set by a user, or developers may precompute their hash for faster
# lookup since it's just the fastest lowest security thing we could find
#
function f #register  #(fr)
end


function f #(a number from 0 to 0xff may be dec or hex)  (font)
end

function fn  #(print normal)
end
