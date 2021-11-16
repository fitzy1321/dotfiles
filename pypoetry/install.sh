install() {
    curr="$DOTFILES/pypoetry"
    dest="$HOME/.config/pypoetry"
    mkdir -p "$dest"

    ln -sf "$curr/config.toml" "$dest/."
}
