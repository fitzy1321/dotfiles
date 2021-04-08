" Langnostic's Neovim Config

" Autoload vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" run :PlugInstall in neovim
call plug#begin('~/.config/vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release' }

call plug#end()

syntax enable
set number

