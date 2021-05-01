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

# fish shell autovenv for python
#set -U autovenv_enable yes
#set -U autovenv_announce yes

# this is a pipenv house now
set pipenv_fish_fancy yes
set -U fish_user_paths ~/.pyenv/shims $fish_user_paths

# homeshick dotfile management
source "$HOME/.homesick/repos/homeshick/homeshick.fish"
source "$HOME/.homesick/repos/homeshick/completions/homeshick.fish"

if test -e ~/.config/fish/secrets.fish
    . ~/.config/fish/secrets.fish
end

# set EDITOR environment variable
set -Ux EDITOR nvim

# aliases

# editors
#alias emacs="emacsclient --tty --create-frame"
alias vim="nvim"

# git shortcuts
alias wip="git commit -a -m wip"
alias amend="git commit --amend -m (git log --oneline --format=%B -n 1 HEAD | head -n 1)"
alias undo="git reset --soft HEAD~1 && git reset HEAD ."
alias oneline="git log --oneline master..."

# TODO: `print` uses prism-cli to highlight code 
#alias print="echo $0; cat $0 | prism -l js" 

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

# add ~/bin to path
set PATH ~/bin $PATH
alias sicp-racket-repl "racket -i -p neil/sicp -l xrepl"

# toolchain
set -U default_npm_packages \
    http-server \
    browser-sync \
    parcel \
    snowpack \
    gatsby \
    onchange \
    lerna \
    # TODO prism-cli \
	tern \
    eslint \
    eslint-config-standard \
    eslint-plugin-standard \
    eslint-plugin-promise \
    eslint-plugin-import \
    eslint-plugin-node \
    eslint-plugin-vue \
    eslint-plugin-mocha \
    neovim \
    @vue/cli \
    @vue/cli-service-global \
    @ceejbot/tarot


function toolchain-node
    npm i -g $default_npm_packages
end

# Build things with real openssl
set -x LDFLAGS  -L/usr/local/opt/openssl/lib
set -x CPPFLAGS -I/usr/local/opt/openssl/include
set -x PKG_CONFIG_PATH /usr/local/opt/openssl/lib/pkgconfig

# Anaconda Jupyter
set -x PATH /usr/local/anaconda3/bin $PATH
