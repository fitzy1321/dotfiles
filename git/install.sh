install() {
    curr="$DOTFILES/git"
    dest="$HOME/.config/git"
    mkdir -p "$dest"

    ln -s "$curr/config" "$dest/."
}

install
