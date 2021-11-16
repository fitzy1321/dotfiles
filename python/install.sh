install() {
    curr="$DOTFILES/python"
    dest="$HOME/.config/python"
    mkdir -p "$dest"

    ln -sf "$curr/pythonrc" "$dest/."
}
