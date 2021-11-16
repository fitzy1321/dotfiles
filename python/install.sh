install() {
    local curr="$DOTFILES/python"
    local dest="$HOME/.config/python"
    mkdir -p "$dest"

    ln -sf "$curr/pythonrc" "$dest/."
}
