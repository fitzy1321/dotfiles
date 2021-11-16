install() {
    local curr="$DOTFILES/pypoetry"
    local dest="$HOME/.config/pypoetry"
    mkdir -p "$dest"

    ln -sf "$curr/config.toml" "$dest/."
}
