#!/usr/bin/env zsh
install() {
    if [ "$PLATFORM" == "Darwin" ]; then
        local NVM_DIR $HOME/.nvm
    else
        local NVM_DIR $HOME/.config/nvm
    fi

    if [ ! -d "$NVIM_DIR" ]; then
        printsl "Download and Install nvm"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

        printsl "Download and Install fisher"
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

        printsl "Install fish-nvm and bass from fisher"
        fisher install FabioAntunes/fish-nvm edc/bass
    fi
}

install
nvm_for_fish_install
