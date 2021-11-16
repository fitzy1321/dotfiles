install() {
    local curr="$DOTFILES/nvim"
    local dest="${NVIM_DIR:-$HOME/.config/nvim}"
    mkdir -p "$dest"

    ln -sf "$curr/init.vim" "$dest/."

    # Install vim-plug
    curl -fLo "$NVIM_DIR/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install
