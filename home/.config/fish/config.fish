# fundle plugins

# colorschemes
fundle plugin 'smh/base16-shell-fish'

# Prompts
#fundle plugin 'pure-fish/pure'
# fundle plugin 'oh-my-fish/theme-bobthefish'
fundle plugin 'oh-my-fish/theme-edan'
# fundle plugin 'metrofish/metrofish'
# fundle plugin 'jorgebucaran/hydro'
# fundle plugin 'oh-my-fish/theme-scorphish'
# fundle plugin 'AdamChristiansen/vertical-fish'
# fundle plugin 'hauleth/agnoster'
#
# use nerd font themeing
set -g theme_nerd_fonts yes

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
fundle plugin 'decors/fish-source-highlight'
fundle plugin 'oh-my-fish/plugin-aws'
fundle plugin 'vincentjames501/fish-kill-on-port'
# fundle plugin 'halostatue/fish-docker'
# fundle plugin 'tuvistavie/fish-watson'

fundle init

# EDITOR
 
set -U EDITOR nvim

# PATH

# add .bin to path
if contains $HOME/bin $fish_user_paths
else
  set -U fish_user_paths $fish_user_paths $HOME/bin
end

# ALIASES

alias vim="nvim"

alias roots="tree -aI '.git|node_modules|.next|.DS_Store'"

# Start or join the "0" tmux session
alias session="tmux new-session -A -s 0"

# useful git convenience aliases
alias yo="git fetch --all && tig --all"
alias undo="git reset --soft HEAD~1 && git reset HEAD ."
alias oneline="git log --oneline main..."
alias wip="git commit -a -m wip"
# todo:(alice) alias amend="git commit --amend -m (git log --format=%B -n 1 HEAD)"

# todo(alice): make "git wtf" a thing
#alias git-wtf="sleep 0.3; and echo \" Fetching all remotes....🚨
#\"; and sleep 0.5; and echo \"     💫 Don't worry! We'll have it sorted soon ✨
#\"; and sleep 1.25; and git fetch --all > /dev/null; and tig --all"
#alias wtf=git-wtf

#alias git-kirby="source $HOME/.bin/_library; ask_with_a_no_default echo('Are you sure you want to rewrite history? ``'; and echo not today" #"git reset --soft @~2; git commit -C @{1}"

# fun git graphs
function git-fetch-river 
  cd 
  git fetch --all
  git log-tree
end
function homeshick-river 
  homeshick cd dotfiles-
  git-fetch-river ./
end

# homebrew openjdk
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths

# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# perl
set -x PATH /Users/alice/perl5/bin $PATH ^/dev/null;
set -q PERL5LIB; and set -x PERL5LIB /Users/alice/perl5/lib/perl5:$PERL5LIB;
set -q PERL5LIB; or set -x PERL5LIB /Users/alice/perl5/lib/perl5;
set -q PERL_LOCAL_LIB_ROOT; and set -x PERL_LOCAL_LIB_ROOT /Users/alice/perl5:$PERL_LOCAL_LIB_ROOT;
set -q PERL_LOCAL_LIB_ROOT; or set -x PERL_LOCAL_LIB_ROOT /Users/alice/perl5;
set -x PERL_MB_OPT --install_base\ \"/Users/alice/perl5\";
set -x PERL_MM_OPT INSTALL_BASE=/Users/alice/perl5;

# fzf.vim wishes I were using bash
function fzf; command fzf $argv; end
function rg; command rg $argv; end

# jump
status --is-interactive; and source (jump shell fish | psub)

