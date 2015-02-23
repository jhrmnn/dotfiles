set shell=/bin/bash
set nocompatible
let mapleader = "\<Space>"
syntax on

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Shougo/vimproc' " makes some plugins faster
Plugin 'bling/vim-airline' " better status line
Plugin 'terryma/vim-multiple-cursors' " sublime text-like behaviour [ctrl-n]
Plugin 'chriskempson/base16-vim' " base16 color scheme
Plugin 'Chiel92/vim-autoformat' " beautifier [:Autoformat]
Plugin 'dag/vim-fish' " fish shell syntax highlight
Plugin 'moll/vim-bbye' " better bdelete
Plugin 'rhysd/clever-f.vim' " improved f F 
Plugin 'tpope/vim-repeat' " improved .
Plugin 'tpope/vim-surround' " better brackets
Plugin 'rking/ag.vim' " faster grep
Plugin 'christoomey/vim-tmux-navigator' " navigating to tmux
Plugin 'ervandew/screen' " screen support
Plugin 'dhruvasagar/vim-table-mode' " plain-text table formatting
Plugin 'Raimondi/delimitMate' " autobrackets
Plugin 'terryma/vim-expand-region' " region expansion
Plugin 'tomtom/tcomment_vim.git' " fast commenting
Plugin 'Lokaltog/vim-easymotion' " fast motion
if $VIM_NO_YCM != '1'
    Plugin 'Valloric/YouCompleteMe' " fast code completion
endif
Plugin 'godlygeek/tabular' " automatic alignment
Plugin 'kien/ctrlp.vim' " fuzzy file search [ctrl-p]
Plugin 'scrooloose/syntastic' " linter support
Plugin 'majutsushi/tagbar' " ctags support [ctrl-b]
Plugin 'tpope/vim-fugitive' " git support
Plugin 'airblade/vim-gitgutter' " git gutter
Plugin 'jcfaria/Vim-R-plugin' " R support
Plugin 'LaTeX-Box-Team/LaTeX-Box' " latex suport
Plugin 'JuliaLang/julia-vim' " julia support
Plugin 'klen/python-mode'  " python support
Plugin 'plasticboy/vim-markdown' "markdown support

call vundle#end()

filetype plugin on
filetype indent on

let maplocalleader = ","

set omnifunc=syntaxcomplete#Complete

let g:ycm_path_to_python_interpreter = '/usr/bin/python'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_semantic_triggers = {
            \  'tex'  : ['{'],
            \ }
" the default ones plus '}\?' at the end
imap íí \begin{
imap éé <Plug>LatexCloseCurEnv
nmap <Leader>ce <Plug>LatexChangeEnv
nmap <Leader>se <Plug>LatexToggleStarEnv

let g:clever_f_smart_case = 1

nnoremap <Leader>p :CtrlP<CR>
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0

let g:LatexBox_latexmk_async = 1
let g:LatexBox_latexmk_preview_continuously = 1
let g:LatexBox_viewer = 'open -a Skim'
let g:LatexBox_quickfix = 2

let g:gitgutter_max_signs = 10000

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvqxyz'
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_target_hl_inc_cursor = 3
map s <Plug>(easymotion-f2)
map S <Plug>(easymotion-F2)
map m <Leader><Leader>w
map M <Leader><Leader>b

" let g:syntastic_check_on_open = 1
let g:syntastic_auto_jump = 2
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_python_checkers = ['pylama']
let g:syntastic_python_pylama_args = 
           \ '-i C901,D100,D101,D102,D103 -l pep8,pyflakes,pep257'
let g:syntastic_fortran_checkers = ['gfortran']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:pymode_lint = 0 " we do this with syntastic
let g:pymode_rope = 0 " this is done by youcompleteme
let g:pymode_folding = 0

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_autopreview = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_width = 35
let g:tagbar_previewwin_pos = 'abo'

let vimrplugin_vsplit = 1

nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-tab> :bnext<CR>
nnoremap <c-s-tab> :bprevious<CR>
nnoremap <Leader><tab> :bnext<CR>
nnoremap <Leader><s-tab> :bprevious<CR>
nnoremap <c-s-tab> :bprevious<CR>
nnoremap <Leader>w :Bdelete<CR>
nnoremap <c-x> :Bdelete<CR>
vmap v <Plug>(expand_region_expand)
vmap <Leader>v <Plug>(expand_region_shrink)
nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>, :set invpaste<CR>

vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

vnoremap <C-K> y:Ag\ "<C-R><C-R>""<CR>
vnoremap <Leader>kf y:Ag\ "<C-R><C-R>"" --fortran<CR>
nnoremap \ :Ag<SPACE>"

set t_Co=256
set background=dark
colorscheme base16-eighties
hi Normal ctermbg=none
hi link EasyMotionTarget2First Question
hi link EasyMotionTarget2Second Question
hi link EasyMotionIncSearch IncSearch

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
set smartcase
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
set viminfo='100,<100,:100,n~/.viminfo
set undofile
set undodir=~/.vim/undo
set nofoldenable
set laststatus=2
set encoding=utf-8
set noerrorbells visualbell t_vb=
set sessionoptions-=options

if filereadable("~/.vimrc_local")
    so ~/.vimrc_local
endif

autocmd FileType fortran setlocal colorcolumn=80 
autocmd FileType fortran setlocal comments=:!>,:!
autocmd FileType fortran setlocal textwidth=80
autocmd FileType fortran setlocal formatoptions=cqroanw
autocmd FileType fortran setlocal number
autocmd BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1

autocmd FileType python setlocal formatoptions=cqroanw

autocmd FileType cpp setlocal colorcolumn=80
autocmd FileType cpp setlocal textwidth=80
autocmd FileType cpp setlocal formatoptions=cqroanw
autocmd FileType cpp setlocal number
autocmd FileType cpp setlocal cino+=(0

autocmd FileType mkd setlocal textwidth=80
autocmd FileType mkd setlocal formatoptions=twanb1
autocmd FileType mkd setlocal spell

autocmd FileType plaintex setlocal filetype=tex

autocmd FileType tex setlocal textwidth=80
autocmd FileType tex setlocal formatoptions=twab1
autocmd FileType tex setlocal number
autocmd FileType tex setlocal ts=2
autocmd FileType tex setlocal sw=2
autocmd FileType tex setlocal sts=2
autocmd FileType tex setlocal spell

autocmd FileType yaml setlocal ts=2
autocmd FileType yaml setlocal sw=2
autocmd FileType yaml setlocal sts=2

autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \     exe "normal! g`\"" |
            \ endif

function! FindProjectName()
    let s:name = fnamemodify(getcwd(), ":t") . "." . 
                \ md5#md5(getcwd()) . ".vim"
    return s:name
endfunction

function! RestoreSession(name)
    if exists("g:my_is_stdin")
        return
    endif
    echo "test"
    echo exists("g:my_is_stdin")
    if filereadable($HOME . "/.vim/sessions/" . a:name)
        execute 'source ' . $HOME . "/.vim/sessions/" . a:name
    end
endfunction

function! SaveSession(name)
    if exists("g:my_is_stdin")
        return
    endif
    execute 'mksession! ' . $HOME . '/.vim/sessions/' . a:name
endfunction

autocmd StdinReadPre * let g:my_is_stdin = 1

if argc() == 0
    autocmd VimLeave * call SaveSession(FindProjectName())
    autocmd VimEnter * nested call RestoreSession(FindProjectName())
end
