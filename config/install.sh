install() {
    local curr="$DOTFILES/config"
    local dest="${CONFIG_DIR:-$HOME/.config}"
    ln -sf "$curr/alacritty.yml" "$dest/."
    ln -sf "$curr/starship.toml" "$dest/."
}
