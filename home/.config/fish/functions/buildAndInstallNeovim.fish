function buildAndInstallNeovim
    cd ~/build/neovim
    and git checkout release-0.5; and git pull;
    and make distclean; and make CMAKE_BUILD_TYPE=Release;
    and sudo make install
    and cd -
end
