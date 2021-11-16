install() {
    curr="$DOTFILES/home"
    [ -f "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$TMP/."
    [ -f "$HOME/.bash_profile" ] && mv "$HOME/.bash_profile" "$TMP/."
    [ -f "$HOME/.profile" ] && mv "$HOME/.profile" "$TMP/.profile"

    ln -sf "$curr/.bashrc" "$HOME/."
    ln -sf "$cure.profile" "$HOME/."
}

install
