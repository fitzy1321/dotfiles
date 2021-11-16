install() {
    local curr="$DOTFILES/git"
    local dest="$HOME/.config/git"
    mkdir -p "$dest"

    ln -s "$curr/config" "$dest/."
}

install
