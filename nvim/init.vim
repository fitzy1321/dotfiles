" Langnostic's Neovim Config

" run this command to install vim-plug
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" Autoload vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  "autocmd VimEnter * PlugInstaall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugin Commands
" :PlugStatus
" :PlugInstall
" PlugUpdate  - Update Plugins
" PlugDiff  - see difference after update
" PlugClean  - remove any plugins no longer defined below
" PlugUpgrade  - upgrade vim-plug it:self
call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'https://github.com/neoclide/coc.nvim'

call plug#end()

" General Settings
syntax enable
set number
set rnu
set encoding=utf-8
set ruler
set wildmenu
set autoindent


" Toggle Relative Numbers
function! ToggleNumbers()
    if(&relativenumber == 1)
        set nornu
    else
        set rnu
    endif
endfunc

let mapleader = ","

" reset init.vim by typing ",sc"
nnoremap <leader>sc :source $MYVIMRC<CR>
nnoremap <leader>tn :call ToggleNumbers()<CR>

" auto source when writing to $MYVIMRC
au! BufWritePost $MYVIMRC source %

