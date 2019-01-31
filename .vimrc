syntax on
filetype plugin indent on
set autoindent
set autoread
set backspace=indent,eol,start
set display=lastline
set encoding=utf-8
set formatoptions=tcq
set history=10000
set hlsearch
set incsearch
set laststatus=2
set listchars="tab:> ,trail:-,nbsp:+"
set nocompatible
set nrformats="bin,hex"
set sessionoptions-=options
set smarttab
set tabpagemax=50
set tags=.tags;,tags
set ttyfast
set viminfo+=!
set wildmenu

set guifont=Hack:h13
set linespace=2

let &undodir = $XDG_DATA_HOME . '/nvim/undo'

source ~/.config/nvim/init.vim
