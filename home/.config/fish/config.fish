# fundle plugins

# colorschemes
fundle plugin 'smh/base16-shell-fish'

# Prompts
fundle plugin 'pure-fish/pure'
# fundle plugin 'oh-my-fish/theme-scorphish'
# fundle plugin 'AdamChristiansen/vertical-fish'
# fundle plugin 'oh-my-fish/theme-bobthefish'
# fundle plugin 'oh-my-fish/theme-edan'
# fundle plugin 'metrofish/metrofish'
# fundle plugin 'rodrigobdz/mooji'
# fundle plugin 'h-matsuo/fish-theme-productive'
# fundle plugin 'jorgebucaran/hydro'
# fundle plugin 'jorgebucaran/gitio.fish'
# fundle plugin 'hauleth/agnoster'

# use nerd font themeing
set -g theme_nerd_fonts yes

# utilities other scripts depend on
fundle plugin 'tuvistavie/fish-completion-helpers'
fundle plugin 'oh-my-fish/plugin-config'
fundle plugin 'tuvistavie/oh-my-fish-core'

# bash script and environment compatability wrappers. AFAIK these all let you
# `replay source <file>` and `replay export VAR='this'`
fundle plugin 'oh-my-fish/plugin-foreign-env'
# fundle plugin 'jorgebucaran/replay.fish'
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
fundle plugin 'laughedelic/pisces'
# fundle plugin 'tuvistavie/fish-fastdir'

# development environment managers
fundle plugin 'FabioAntunes/fish-nvm'
fundle plugin 'oh-my-fish/plugin-pyenv'
fundle plugin 'oh-my-fish/plugin-rustup'
# fundle plugin 'oh-my-fish/plugin-rbenv'

# OS specific aliases, etc.
# fundle plugin 'oh-my-fish/plugin-osx'
# fundle plugin 'oh-my-fish/plugin-archlinux'

# Utilities that aren't for everyone
fundle plugin 'gazorby/fish-abbreviation-tips'
fundle plugin 'decors/fish-source-highlight'
# fundle plugin 'oh-my-fish/plugin-aws'
# fundle plugin 'halostatue/fish-docker'
# fundle plugin 'vincentjames501/fish-kill-on-port'
# fundle plugin 'tuvistavie/fish-watson'

fundle init

# EDITOR
 
set -U EDITOR nvim

# PATH

# add .bin to path
if contains $HOME/.bin $fish_user_paths
else
	set -U fish_user_paths $fish_user_paths $HOME/.bin
end

# ALIASES

alias roots="tree -aI '.git'"

# Start or join the "0" tmux session
alias session="tmux new-session -A -s 0"

# useful git convenience aliases
alias yo="git fetch --all && tig --all"
alias undo="git reset --soft HEAD~1 && git reset HEAD ."
alias oneline="git log --oneline master..."
alias wip="git commit -a -m wip"
alias amend="git commit -a --amend -m (git log --oneline --format=%B -n 1 HEAD | head -n 1)"

# todo(alice): make "git wtf" a thing
#alias git-wtf="sleep 0.3; and echo \" Fetching all remotes....🚨
#\"; and sleep 0.5; and echo \"     💫 Don't worry! We'll have it sorted soon ✨
#\"; and sleep 1.25; and git fetch --all > /dev/null; and tig --all"
#alias wtf=git-wtf
alias "git\ wtf"=wtf

#alias git-kirby="source $HOME/.bin/_library; ask_with_a_no_default echo('Are you sure you want to rewrite history? ``'; and echo not today" #"git reset --soft @~2; git commit -C @{1}"


# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# jump
status --is-interactive; and source (jump shell fish | psub)
