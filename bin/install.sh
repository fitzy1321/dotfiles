install() {
    curr="$DOTFILES/bin"
    dest="$Home/bin"
    mkdir -p "$dest"

    ln -sf "$curr/fontcache" "$dest/."
    ln -sf "$curr/get-gnome-themes.sh" "$dest/."
    ln -sf "$curr/touchx" "$dest/."
}

install
