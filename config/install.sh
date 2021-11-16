install() {
    curr="$DOTFILES/config"
    dest="$HOME/.config"
    ln -sf "$curr/alacritty.yml" "$dest/."
    ln -sf "$curr/starship.toml" "$dest/."
}
