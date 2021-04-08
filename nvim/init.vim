" Langnostic's Neovim Config

" Autoload vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" run :PlugInstall
call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release' }

call plug#end()

syntax enable
set number

" Toggle Relative Numbers
function! ToggleNumbers()
    if(&relativenumber == 1)
        set nornu
    else
        set rnu
    endif
endfunc

call ToggleNumbers()

let mapleader = ","

" reset init.vim by typing ",sc"
nnoremap <leader>sc :source $MYVIMRC<CR>
nnoremap <leader>tn :call ToggleNumbers()<CR>

