let xdg_data_home = $XDG_DATA_HOME ? $XDG_DATA_HOME : ($HOME . '/.local/share')
set clipboard=unnamed
set completeopt-=preview
let &directory = xdg_data_home . '/nvim/swap//,.'
set expandtab
set exrc
set foldlevelstart=99
set gdefault
set hidden
set ignorecase
set linebreak
set noerrorbells
set noshowmode
set secure
set shiftround
set shiftwidth=4
set softtabstop=4
set shortmess+=s
set showmatch
set smartcase
set smartindent
set timeoutlen=500
set title
let &undodir = xdg_data_home . '/nvim/undo//'
set undofile
set visualbell
set wrap
if has('nvim')
    set diffopt+=vertical,algorithm:histogram,indent-heuristic
    set inccommand=split
endif

colorscheme jhrmnn

let mapleader = ' '
let maplocalleader = ' '

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

augroup file_types
    autocmd!
    autocmd BufEnter /private/tmp/crontab.* setl bkc=yes
    autocmd BufEnter term://* startinsert
    autocmd BufRead,BufNewFile *.pyi setl ft=python
    autocmd BufRead,BufNewFile *.pyx setl ft=cython
    autocmd BufRead,BufNewFile *.F90 setl ft=fortran
    autocmd FileType cpp setl cc=80 tw=80 fo=croqw cino+="(0"
    autocmd FileType fortran setl cc=80,133 tw=80 com=:!!,:!>,:! fo=croq nu
    autocmd FileType javascript setl cc=80 nu
    autocmd FileType javascript setl ts=2 sw=2 sts=2
    autocmd FileType markdown setl tw=80 spell ci pi sts=0 sw=4 ts=4
    autocmd FileType mediawiki setl tw=80 spell ci pi sts=0 sw=4 ts=4
    autocmd FileType python setl nosi cc=80 tw=80 fo=croq nu cino+="(0"
    autocmd FileType rst setl spell | syn spell toplevel
    autocmd FileType tex setl tw=80 ts=2 sw=2 sts=2 spell
    autocmd FileType yaml setl ts=2 sw=2 sts=2
augroup END
