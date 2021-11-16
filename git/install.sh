install() {
    mkdir -p "$HOME/.config/git"
    ln -s "$DOTFILES/git/config" "$HOME/.config/git/."
}

install
