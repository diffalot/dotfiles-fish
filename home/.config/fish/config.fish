# setup racket path
set PATH $HOME/build/racket-7.1.0.2/bin $PATH

# setup rbenv path
set PATH $HOME/.rbenv/bin $PATH

# use nerd font themeing
set -g theme_nerd_fonts yes

# setup ssh-agent
set -U keychain_init_args --quiet --agents ssh,gpg id_rsa 0xBC76F379DB7CE625

# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

# aliases
alias emacs="emacsclient --tty --create-frame"
alias vim="nvim"

# toolchain
set -U default_npm_packages \
    http-server \
    nodemon \
    lerna \
    tern \
    js-beautify \
    eslint \
    eslint-config-standard \
    eslint-plugin-standard \
    eslint-plugin-promise \
    eslint-plugin-import \
    eslint-plugin-node \
    neovim


function toolchain-node
    npm i -g $default_npm_packages
end

