filetype plugin indent on                       "show existing tab with 4 spaces width
set tabstop=4                                   "when indenting with '>', use 4 spaces width
set shiftwidth=4                                "On pressing tab, insert 4 spaces
set expandtab
set background=dark
set number
set hlsearch
set incsearch
let g:netrw_liststyle = 3
set lazyredraw                                   " enable lazyredraw
set nocursorline                                 " disable cursorline
set ttyfast                                      " enable fast terminal connection
set term=xterm-256color                          " terminal type
syntax enable
"set laststatus=2
"call plug#begin('~/.vim/plugged')
"Plug 'scrooloose/nerdtree' 
"Plug 'lervag/vimtex'
"Plug 'ycm-core/YouCompleteMe'
"call plug#end()
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
