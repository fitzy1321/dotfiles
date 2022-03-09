#!/usr/bin/env zsh
install() {
    if [ "$PLATFORM" == "Darwin" ]; then
        local NVM_DIR $HOME/.nvm
    else
        local NVM_DIR $HOME/.config/nvm
    fi

    if [ ! -d "$NVIM_DIR" ]; then
        echo "Download and Install nvm"
        sleep 1
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

        echo "Download and Install fisher"
        sleep 1
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

        echo "Install fish-nvm and bass from fisher"
        sleep 1
        fisher install FabioAntunes/fish-nvm edc/bass
    fi
}

install
