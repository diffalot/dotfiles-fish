# PATH
# add .bin to path
if contains $HOME/bin $fish_user_paths
else
  set -U fish_user_paths $fish_user_paths $HOME/bin
end

# EDITOR
set -U EDITOR nvim

# FUNCTIONS
# print out a directory tree without junk
function roots
  # todo(alice) make this read from git ignore
  tree -aI '.git|node_modules|.next|.DS_Store' $args
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
  git-fetch-river ./
end

function buildAndInstallNeovim
  cd ~/build/neovim
  and git checkout master; and git pull;
  and make distclean; and make CMAKE_BUILD_TYPE=Release;
  and sudo make install
  and cd -
end

# stash functions that use a number, just a number
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
alias vim="nvim"

# Start or join the "0" tmux session
alias session="tmux new-session -A -s '☡'"

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

# OS Specific Inclusions
switch (uname)
case Linux
case FreeBSD NetBSD DragonFly
case Darwin

  # I think this is gonna only be on my macOS machines
  fundle plugin 'oh-my-fish/plugin-aws'

  # homebrew openjdk
  set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

  # homebrew shell completion
  if test -d (brew --prefix)"/share/fish/completions"
      set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
  end
  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
      set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
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

# fundle plugins

# Prompts

# colorschemes
fundle plugin 'smh/base16-shell-fish'
# use nerd font themeing
set -g theme_nerd_fonts yes
fundle plugin 'acomagu/fish-async-prompt'

fundle plugin 'diffalot/pure'

# fundle plugin 'pure-fish/pure'
# fundle plugin 'oh-my-fish/theme-bobthefish'
# fundle plugin 'oh-my-fish/theme-edan'
# fundle plugin 'metrofish/metrofish'
# fundle plugin 'jorgebucaran/hydro'
# fundle plugin 'oh-my-fish/theme-scorphish'
# fundle plugin 'AdamChristiansen/vertical-fish'
# fundle plugin 'hauleth/agnoster'

# utilities other scripts depend on
fundle plugin 'tuvistavie/fish-completion-helpers'
fundle plugin 'oh-my-fish/plugin-config'
fundle plugin 'tuvistavie/oh-my-fish-core'

# bash script and environment compatability wrappers. AFAIK these all let you
# `replay source <file>` and `replay export VAR='this'`
# fundle plugin 'jorgebucaran/replay.fish'
fundle plugin 'oh-my-fish/plugin-foreign-env'
fundle plugin 'edc/bass'

# todo(alice) it seems that pkg-keychain works well on macOS
# but not on Ubuntu??? surely I can fix that with dedicated time, eventually.
# I with that fish-ssh-agent doesn't ask me for my pass as soon as I log
# in and "that ought to be easy"
# ssh agents
fundle plugin 'danhper/fish-ssh-agent'
# fundle plugin 'jitakirin/pkg-keychain'
# set -U keychain_init_args --quiet --agents ssh id_rsa

# efficiency tools
fundle plugin 'patrickf3139/Colored-Man-Pages'
fundle plugin 'jorgebucaran/fishtape'
# fundle plugin 'tuvistavie/fish-fastdir'
fundle plugin 'jorgebucaran/autopair.fish'

# development environment managers
fundle plugin 'FabioAntunes/fish-nvm'
fundle plugin 'oh-my-fish/plugin-pyenv'
fundle plugin 'oh-my-fish/plugin-rustup'
# fundle plugin 'oh-my-fish/plugin-rbenv'
#
# OS specific aliases, `etc.
# fundle plugin 'oh-my-fish/plugin-osx'
# fundle plugin 'oh-my-fish/plugin-archlinux'

# Utilities that aren't for everyone
fundle plugin 'gazorby/fish-abbreviation-tips'
#Could be causeing the oddities I 'm seeing with `less` fundle plugin 'decors/fish-source-highlight'
# fundle plugin 'oh-my-fish/plugin-aws'
fundle plugin 'vincentjames501/fish-kill-on-port'
# fundle plugin 'halostatue/fish-docker'
# fundle plugin 'tuvistavie/fish-watson'

# finally initialize fundle
fundle init
