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

" Toggle Relative Numbers
function! NumberToggle()
    if(&relativenumber == 1)
        set nornu
	set number
    else
        set rnu
    endif
endfunc

let mapleader = ","

" reset init.vim by typing ",sc"
nnoremap <leader>sc :source $MYVIMRC<CR>
nnoremap <leader>rn :call NumberToggle()<CR>
