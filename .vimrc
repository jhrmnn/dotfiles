syntax on
filetype indent plugin on
set bs=indent,eol,start
set nocompatible
set modeline
set background=dark
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set wrap linebreak nolist
set autochdir
set showmatch
set clipboard+=unnamed
set nolist
set title
set textwidth=0
set wrapmargin=0
set wildmenu
set incsearch
set autoindent
set hlsearch
set pastetoggle=<F10>
set clipboard=unnamed

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

if filereadable("_vimrc")
    so _vimrc
endif

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

"au BufWinLeave *.* mkview
"au BufWinEnter *.* silent loadview

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Bundle 'wakatime/vim-wakatime'
Bundle 'kien/ctrlp.vim'
"Bundle 'davidhalter/jedi-vim'
Bundle 'terryma/vim-multiple-cursors'
Plugin 'klen/python-mode'

call vundle#end()

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:pymode_options_colorcolumn = 0
let g:pymode_folding = 0
let g:pymode_rope_complete_on_dot = 0

let $GIT_SSL_NO_VERIFY = 'true'
