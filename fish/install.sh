nvm_for_fish_install() {
    printsl "Download and Install nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

    printsl "Download and Install fisher"
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

    printsl "Install bass from fisher"
    fisher install edc/bass
}

install() {
    FISH_PATH = "${FISH_PATH:-$HOME/.config/fish}"
    mkdir -p "$FISH_PATH"

    ln -sf "$DOTFILES/fish/config.fish" "$FISH_PATH/."
    ln -sf "$DOTFILES/fish/abbrevs.fish" "$FISH_PATH/."
    ln -sf "$DOTFILES/fish/setup_tools.fish" "$FISH_PATH/."
    ln -sf "$DOTFILES/fish/completions" "$FISH_PATH/."
    ln -sf "$DOTFILES/fish/functions/nvm.fish" "$FISH_PATH/functions/."

    nvm_for_fish_install
}

install
