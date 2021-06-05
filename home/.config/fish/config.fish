# PATH
# add .bin to path
if contains $HOME/bin $fish_user_paths
else
  set -U fish_user_paths $fish_user_paths $HOME/bin
end

set -g theme_nerd_fonts yes

# EDITOR
set -U EDITOR kak
set -U VISUAL kak

# FUNCTIONS
# print out a directory tree without junk
function roots
  # todo(alice) make this read from git ignore
  tree -aI '.git|node_modules|.next|.DS_Store' -- $argv
end

# fetch all remotes after changing directories
# into a repository then print a pretty graph
function git-fetch-river
  cd $args
  git fetch --all
  git log-tree
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
  stash-show $num
  git stash drop stash@\{$num\}
end
function stash-diff-to -a num
  echo
  echo Here is the diff from your HEAD to stash@\{$num\}\:
  git diff stash@\{$num\}
end

# ALIASES
alias vim="kak"
alias nvim="kak"

## Start or join the main tmux session and sync cronofiles
alias session="tmux new-window -t '☡' \
    ' \ echo
        && echo '' \
        \
        && fish \
    '; \
    and tmux attach -t '☡' \
        && colorwheel \
"

# Start or join the main tmux session and sync cronofiles if the session is
# being started. also, set files to sync when the session exits cleanly. As
# a bonus, kill any session 0 that exists as the session starts and exits
#
# alias must include a long running command to stay attached \
#
# TODO figure out why session 0 always starts up \
#
alias session-start="tmux new-session -A -s '☡'"

# TODO convert most aliases to abbreviations
# useful git convenience aliases
alias yo="git fetch --all && tig --all"
alias undo="git reset --soft HEAD~1 && git reset HEAD ."
alias oneline="git log --oneline main..."
alias wip="git commit -a -m wip"
# todo:(alice) fix amend
# alias amend="git commit --amend -m (git log --format=%B -n 1 HEAD)"

# todo(alice): make "git wtf" a thing
# alias git-wtf="sleep 0.3; and echo \" Fetching all remotes....🚨
# \"; and sleep 0.5; and echo \"     💫 Don't worry! We'll have it sorted soon ✨
# \"; and sleep 1.25; and git fetch --all > /dev/null; and tig --all"

# todo(alice) validate the ask function with fishtape tests then make it ask
# twice before your current commit can eat it's parent.
# alias git-kirby="source $HOME/.bin/_library; ask_with_a_no_default echo('Are you sure you want to rewrite history? ``'; and echo not today" #"
alias git-eat-parent "git reset --soft @~2; git commit -C @{1}"

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
