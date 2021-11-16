install() {
    NVIM_DIR="${NVIM_DIR:-$HOME/.config/nvim}"
    mkdir -p "$NVIM_DIR"

    # Install vim-plug
    curl -fLo "$NVIM_DIR/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install
