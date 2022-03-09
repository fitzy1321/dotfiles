install() {
    if [ "$PLATFORM" == "Linux" ]; then
        local dest="$HOME/.config/pypoetry"
    else
        local dest="$HOME/Library/Application\ Support/pypoetry"
    fi
    local curr="$DOTFILES/pypoetry"
    mkdir -p "$dest"

    ln -sf "$curr/config.toml" "$dest/."
}
