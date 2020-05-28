# configuration based on system architecture
switch (uname -m)
case armv7l # raspberry pi
end

# configuration based on distribution
switch (uname)
case Linux
    # setup rbenv
    set -Ux fish_user_paths $HOME/.rbenv/bin $fish_user_paths
    status --is-interactive; and source (rbenv init -|psub)
end

# use nerd font themeing
set -g theme_nerd_fonts yes

# setup ssh-agent
set -U keychain_init_args --quiet --agents ssh,gpg id_rsa 0xBC76F379DB7CE625

# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

if test -e ~/.config/fish/secrets.fish
    . ~/.config/fish/secrets.fish
end

# set EDITOR environment variable
set -Ux EDITOR nvim

# aliases
#alias emacs="emacsclient --tty --create-frame"
alias vim="nvim"
alias wip="git commit -a -m wip"
alias amend="git commit -a --amend -m (git log --oneline --format=%B -n 1 HEAD | head -n 1)"
alias undo="git reset --soft HEAD~1 && git reset HEAD ."
alias oneline="git log --oneline master..."

# Android SDK
set ANT_HOME /usr/local/opt/ant
set MAVEN_HOME /usr/local/opt/maven
set GRADLE_HOME /usr/local/opt/gradle
set ANDROID_HOME /usr/local/share/android-sdk
set ANDROID_NDK_HOME /usr/local/share/android-ndk
set INTEL_HAXM_HOME /usr/local/Caskroom/intel-haxm
#set ANDROID_SDK_ROOT  /usr/local/Caskroom/android-sdk/4333796
#set ANDROID_SDK_ROOT  $ANDROID_HOME
#set ANDROID_AVD_HOME $HOME/.android/avd

set PATH $ANT_HOME/bin $PATH
set PATH $MAVEN_HOME/bin $PATH
set PATH $GRADLE_HOME/bin $PATH
set PATH $ANDROID_HOME/tools $PATH
set PATH $ANDROID_HOME/platform-tools $PATH
set PATH $ANDROID_HOME/build-tools/19.1.0 $PATH

alias android-emulator "echo \"not set up\""

# Medium environment
if test -e /opt/medium/env
    bass source /opt/medium/env
    set -Ux ALLOW_NO_REVIEWERS 1
    ssh-add -K ~/.ssh/medium_rsa.pem
end

# spark path
if test -e /usr/local/spark/bin
    set PATH /usr/local/spark/bin $PATH
end

# add ~/bin to path
set PATH ~/bin $PATH
alias sicp-racket-repl "racket -i -p neil/sicp -l xrepl"

# toolchain
set -U default_npm_packages \
    http-server \
    browser-sync \
    parcel \
    nodemon \
    onchange \
    lerna \
    tern \
    flow-bin \
    jest \
    typescript \
    js-beautify \
    eslint \
    eslint-config-standard \
    eslint-plugin-standard \
    eslint-plugin-promise \
    eslint-plugin-import \
    eslint-plugin-node \
    eslint-plugin-vue \
    eslint-plugin-mocha \
    neovim \
    yo \
    generator-generator \
    @vue/cli \
    @vue/cli-service-global \
    npmrc \
    @ceejbot/tarot


function toolchain-node
    npm i -g $default_npm_packages
end

set -U patronus_servers \
    lite \
    rito \
    medium2

function patronus
    cd ~/code/mono/ts/lite
    yarn auth
    for server in $patronus_servers
        tmux split-window -t 2 -p 90 "yarn dev $server; or fish"
    end
end
