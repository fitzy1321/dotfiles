install() {
    [ -f "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$TMP/."
    [ -f "$HOME/.bash_profile" ] && mv "$HOME/.bash_profile" "$TMP/."

    ln -sf "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"

}

install
