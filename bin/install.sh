install() {
    mkdir -p "$HOME/bin"
    ln -sf "$ODTFILES/bin/fontcache" "$HOME/bin/."
    ln -sf "$DOTFILES/bin/get-gnome-themes.sh" "$HOME/bin/."
    ln -sf "$DOTFILES/bin/touchx" "$HOME/bin/."
}

install
