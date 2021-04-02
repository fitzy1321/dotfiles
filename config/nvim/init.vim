" Langnostic's Neovim Config

" Install vim-plug if not found
if empty(glob('~/.config/nvim/autoload/plug.vim')) 
    silent! curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" do I need todo auto install plugin command?

syntax enable	" syntax highlighting
set number	" show line numbers

