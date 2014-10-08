set shell=/bin/bash
set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'terryma/vim-multiple-cursors'
Plugin 'chriskempson/base16-vim'
Plugin 'dag/vim-fish'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'

call vundle#end()

syntax on
filetype plugin on
filetype indent on

"let g:syntastic_check_on_open = 1
let g:syntastic_auto_jump = 2
let g:syntastic_auto_loc_list = 1
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_python_pylama_args = '-i C901'

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:pymode_folding = 0
"let $GIT_SSL_NO_VERIFY = 'true'

nmap <F8> :TagbarToggle<CR>

set background=dark
colorscheme base16-eighties
hi Normal ctermbg=none

set clipboard=unnamed
set wildmenu
set backspace=indent,eol,start
set gdefault
set encoding=utf-8 nobomb
set directory=~/.vim/swaps
set exrc
set secure
set hlsearch
set ignorecase
set modeline
set incsearch
set mouse=a
set showmode
set showmatch
set nolist
set title
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set wrap linebreak nolist
set autochdir

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

let maplocalleader = ","

vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
