install() {
    [ -f "$HOME/.profile" ] && mv "$HOME/.profile" "$TMP/.profile"

    ln -sf "$DOTFILES_DIR/.profile" "$HOME/."
    ln -sf "$DOTFILES_DIR/alacritty.yml" "$CONFIG/."
    ln -sf "$DOTFILES_DIR/starship.toml" "$CONFIG/."

}

install
