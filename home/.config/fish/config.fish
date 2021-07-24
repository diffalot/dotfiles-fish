# PATH
fish_add_path $HOME/bin 
fish_add_path $HOME/.local/bin 

set -g theme_nerd_fonts yes

# EDITOR
set -U EDITOR nvim
set -U VISUAL nvim

# ALIASES
alias vim="nvim"
#alias nvim="nvim"
alias less="bat"
alias ls="lsd"
alias random-colors="echo --reverse (random choice (set_color --print-colors))"

# FUNCTIONS
# print out a directory tree without junk
function root
    # todo(alice) make this read from git ignore
    tree -aI '.git|node_modules|.next|.DS_Store' -- $argv
end

# fetch all remotes after changing directories
# into a repository then print a pretty graph
function git-fetch-river
    cd $argv[0]
    git fetch --all
    git log-tree $argv
end

# homeshick cd into a repo and print the graph
function homeshick-river
    homeshick cd dotfiles-
    git-fetch-river
end


function buildAndInstallNeovim
    cd ~/build/neovim
    and git checkout master; and git pull;
    and make distclean; and make CMAKE_BUILD_TYPE=Release;
    and sudo make install
    and cd -
end

function buildAndInstallFishShell
    cd ~/build/fish-shell
    and git checkout master; and git pull;
    and mkdir -p build; and cd build;
    and cmake ..
    and make;
    and sudo make install
    and cd -
end
# git stash functions that use a number, just a number
function stash-list
    echo
git stash list
    # and some are in here just for consistency
end
function stash-show -a num
    echo
    echo Here is the patch from stash@\{$num\}\:
    git stash show -p stash@\{$num\}
    echo
end
function stash-apply -a num
    echo
    echo We are applying stash@\{$num\}
    stash-show $num
    echo
    git stash pop stash@\{$num\}
end
function stash-drop --argument num
    echo
    echo We are dropping stash@\{$num\}
    git stash drop stash@\{$num\}
end
function stash-diff-to -a num
    # TODO: this is either broken or doesn't look like I thought it would
    echo
    echo Here is the diff from your HEAD to stash@\{$num\}\:
    git diff HEAD stash@\{$num\}
end

function git-shortcuts
echo "
undo  - undoes the last commit and the changes are left staged
uundo - undoes the last commit and the changes are left unstaged

amend - adds staged changes to the last commit (but only if you were the author)

Each level of wip will run each lower level so that when you return to your
    senses or even if not, when you have to sort through the mess, hopefully 
    it'll be a little easier with separate commits for what  you meant to 
    write (wip), what you wrote (wwip), what you wrote that you 
    shouldn't have (wwwip), and finally, everything you had to change in the 
    whole damn repo (wwwwip).

wip <message>    - commits whatever is staged as \"[wip](squash) <message>\"
                   git commit -m \"[wip](squash) $argv\"
wwip <message>   - commits whatever is changed as \"[wip](sort) <message>\"
                   git commit -am \"[wip](sort) $argv\"
wwwip <message>  - commits whatever is in the current directory as \"[wip](Oh No!) <message>\"
                   git add .; git commit -am \"[wip](Oh No!) $argv\"
wwwwip <message> - commits everything in the entire repo as \"[wip](Oh No!) <message>\"
                   git add (git rev-parse --show-toplevel); git commit -am \"[wip](...really?) $argv\"

(there are also shortcuts for squashing...)
"
end

# Git WIP in a hurry
function wip --description 'WIP commit after adding files with `git commit -m "[wip](rush) $argv"`'
    git commit -m "[wip](squash) $argv"  
end
function wwip --description 'WIP commit with all changed files via `git commit -am "[wip](rush) $argv"`'
    wip $argv;
    git commit -am "[wip](sort) $argv"  
end
function wwwip --description 'WIP commit it all with `git add .; git commit -am "[wip](Oh No!) $argv"`'
    wwip $argv;
    git add .
    git commit -am "[wip](Oh No!) $argv"
end
function wwwwip --description 'WIP commit everything in the repo with `git add (git root); git commit -am "[wip](...really?) $argv"`'
    wwwip $argv
    git add  (git rev-parse --show-toplevel)
    git commit -am "[wip](...really?) $argv"
end

function amend
    set -l my_name (git config user.name)
    set -l my_email (git config user.email)

    set -l previous_author (git log -n 1 --format="%aN %aE")
    if test "$previous_author" != "$my_name $my_email"
        set_color red --bold
        echo "Take a break... You just tried to amend a commit by" (git log -n 1 --format=%aN) '.'
        set_color normal
    else
        set -l lastcommit (git log -n 1 --format="%H")
        git commit --amend --reuse-message=$lastcommit
    end
end

#onchange -i functions/scm-convert-colorspace.fish -- fish -c "source functions/scm-convert-colorspace.fish && scm-rgba-to-hex '25%, 100%, 55% / .5' | pipe-pad-with-color (random-colors) && echo && echo"

# most aliases should be abbreviations
# but some are too important to be easy to edit
# useful git convenience aliases
alias undo="git reset --soft HEAD~1"
alias uundo="git reset --soft HEAD~1 && git reset HEAD ."
alias git-eat-parent "git reset --soft @~2; 
git commit -C @{1}"
alias git-wtf='sleep 0.3; and echo " Fetching all remotes....🚨 \
"; and sleep 0.5; and echo "     💫 Don\'t worry! We\'ll have it sorted soon ✨
"; and sleep 1.25; and git fetch --all > /dev/null; and tig --all'

# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# async prompt for pure
set -g async_prompt_functions _pure_prompt_git

# OS Specific Inclusions
switch (uname)
    case Linux
    case FreeBSD NetBSD DragonFly
    case Darwin

    # jump
    status --is-interactive; and source (jump shell fish | psub)

    # homebrew openjdk
    set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

    # homebrew shell completion
    if test -d (brew --prefix)"/share/fish/completions"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish vendor_completions.d
    end

    # perl
    set -x PATH /Users/alice/perl5/bin $PATH ^/dev/null;
    set -q PERL5LIB; and set -x PERL5LIB /Users/alice/perl5/lib/perl5:$PERL5LIB;
    set -q PERL5LIB; or set -x PERL5LIB /Users/alice/perl5/lib/perl5;
    set -q PERL_LOCAL_LIB_ROOT; and set -x PERL_LOCAL_LIB_ROOT /Users/alice/perl5:$PERL_LOCAL_LIB_ROOT;
    set -q PERL_LOCAL_LIB_ROOT; or set -x PERL_LOCAL_LIB_ROOT /Users/alice/perl5;
    set -x PERL_MB_OPT --install_base\ \"/Users/alice/perl5\";
    set -x PERL_MM_OPT INSTALL_BASE=/Users/alice/perl5;

    case '*'
end

if tput cols > 74
else
end

#if test -n "$TMUX"
#    set -lx NVIM_LISTEN_ADDRESS (tmux show-environment NVIM_LISTEN_ADDRESS | sed -r 's/NVIM_LISTEN_ADDRESS=//')
#    if not test -S "$NVIM_LISTEN_ADDRESS"
#        bash -c "~/.tmux/plugins/tmux-nvr/scripts/nvim-listen.sh"
#        set -lx NVIM_LISTEN_ADDRESS (tmux show-environment NVIM_LISTEN_ADDRESS | sed -r 's/NVIM_LISTEN_ADDRESS=//')
#    end
#else
#    set -l NVIM_LISTEN_ADDRESS /tmp/nvimsocket
#end

#colorwheel
#fzf_configure_bindings
fish_vi_key_bindings
