# use nerd font themeing
set -g theme_nerd_fonts yes

# setup ssh-agent
set -U keychain_init_args --quiet --agents ssh id_rsa

# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# aliases
alias emacs="emacs --no-window-system"

# setup racket path
set PATH $HOME/build/racket-7.1.0.2/bin $PATH
