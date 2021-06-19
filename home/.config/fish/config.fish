# PATH
# add .bin to path
if contains $HOME/bin $fish_user_paths
else
    set -U fish_user_paths $fish_user_paths $HOME/bin
end

set -g theme_nerd_fonts yes

# EDITOR
set -U EDITOR nvim
set -U VISUAL nvim

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
    and make clean;
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

#alias amend="git commit --amend -m (lastlog)"
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


# ALIASES
alias vim="nvim"
alias nvim="nvim"
alias less="bat --italic-text always --theme base16"

# convert most aliases to abbreviations
# but some are too important to be easy to edit
# useful git convenience aliases
alias wip="git commit -m wip"
alias undo="git reset --soft HEAD~1 && git reset HEAD ."
alias git-eat-parent "git reset --soft @~2; git commit -C @{1}"
alias git-wtf='sleep 0.3; and echo " Fetching all remotes....🚨 \
"; and sleep 0.5; and echo "     💫 Don\'t worry! We\'ll have it sorted soon ✨
"; and sleep 1.25; and git fetch --all > /dev/null; and tig --all'

# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# jump
status --is-interactive; and source (jump shell fish | psub)

# async prompt for pure
set -g async_prompt_functions _pure_prompt_git

# OS Specific Inclusions
switch (uname)
    case Linux
    case FreeBSD NetBSD DragonFly
    case Darwin

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

#colorwheel

fish_vi_key_bindings
