filetype plugin indent on
syntax on

set nocompatible
set shell=/bin/bash
set background=dark
set wildmenu
set backspace=indent,eol,start
set gdefault
set encoding=utf-8 nobomb
set directory=~/.vim/swaps
set exrc
set hlsearch
set ignorecase
set smartcase
set incsearch
set mouse=a
set clipboard=unnamed
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
let g:tex_flavor = "latex"
let g:clever_f_smart_case = 1
if v:version > 704 || v:version == 704 && has('patch338')
    set breakindent
    set breakindentopt=shift:2
    let &showbreak = '> '
endif

highlight Normal ctermbg=none
highlight ColorColumn ctermbg=8
highlight link EasyMotionTarget2First Question
highlight link EasyMotionTarget2Second Question
highlight link EasyMotionIncSearch IncSearch

nnoremap <c-tab> :bnext!<CR>
nnoremap <c-s-tab> :bprevious!<CR>
nnoremap <Leader><tab> :bnext!<CR>
nnoremap <Leader><s-tab> :bprevious!<CR>
nnoremap <Leader>w :Bdelete<CR>
nnoremap <c-x> :Bdelete<CR>
nnoremap <Leader>n :noh<CR>
nnoremap <Leader>, :set invpaste<CR>
nnoremap <Leader>a :call ToggleAutoFormatting()<CR>

autocmd FileType fortran setlocal colorcolumn=80 
autocmd FileType fortran setlocal comments=:!>,:!
autocmd FileType fortran setlocal textwidth=80
autocmd FileType fortran setlocal formatoptions=cqroanw2
autocmd FileType fortran setlocal number
autocmd BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
autocmd BufRead,BufNewFile *.f90 let b:fortran_more_precise=1

autocmd FileType python setlocal colorcolumn=80
autocmd FileType python setlocal formatoptions=cqroanw
autocmd FileType python setlocal textwidth=79
autocmd FileType python setlocal number
autocmd FileType python setlocal cino+=(0

autocmd FileType javascript setlocal colorcolumn=80
autocmd FileType javascript setlocal number

autocmd FileType cpp setlocal colorcolumn=80
autocmd FileType cpp setlocal textwidth=80
autocmd FileType cpp setlocal formatoptions=cqroanw
autocmd FileType cpp setlocal number
autocmd FileType cpp setlocal cino+=(0

autocmd FileType mkd setlocal textwidth=80
autocmd FileType mkd setlocal formatoptions=wnb1vb
autocmd FileType mkd setlocal spell
autocmd FileType mkd setlocal noet ci pi sts=0 sw=4 ts=4

autocmd FileType tex setlocal textwidth=80
autocmd FileType tex setlocal formatoptions=tcqroaw1
autocmd FileType tex setlocal number
autocmd FileType tex setlocal ts=2
autocmd FileType tex setlocal sw=2
autocmd FileType tex setlocal sts=2
autocmd FileType tex setlocal spell
autocmd FileType tex syntax spell toplevel

autocmd FileType yaml setlocal ts=2
autocmd FileType yaml setlocal sw=2
autocmd FileType yaml setlocal sts=2

autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \     exe ":normal! g`\"" |
            \ endif

function! ToggleAutoFormatting()
    if &fo =~ "a"
        setl fo-=a
        echo "Autoformat off"
    else
        setl fo+=a
        echo "Autoformat on"
    endif
endfunction

function! FindProjectName()
    let s:name = fnamemodify(getcwd(), ":t") . "." . 
                \ md5#md5(getcwd()) . ".vim"
    return s:name
endfunction

function! RestoreSession(name)
    if exists("g:my_is_stdin")
        return
    endif
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

if argc() == 0 && v:version > 703
    autocmd VimLeave * call SaveSession(FindProjectName())
    autocmd VimEnter * nested call RestoreSession(FindProjectName())
end
let mapleader = ' '
let maplocalleader = ' '

"" settings below concerns plugins

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Shougo/vimproc' " makes some plugins faster
Plugin 'bling/vim-airline' " better status line
Plugin 'terryma/vim-multiple-cursors' " sublime text-like behaviour [ctrl-n]
Plugin 'Chiel92/vim-autoformat' " beautifier [:Autoformat]
Plugin 'dag/vim-fish' " fish shell syntax highlight
Plugin 'moll/vim-bbye' " better bdelete
Plugin 'rhysd/clever-f.vim' " improved f F 
Plugin 'tpope/vim-repeat' " improved .
Plugin 'tpope/vim-surround' " better brackets
Plugin 'rking/ag.vim' " faster grep
Plugin 'christoomey/vim-tmux-navigator' " navigating to tmux
Plugin 'ervandew/screen' " screen support
Plugin 'chriskempson/base16-vim' " base16 for gvim
Plugin 'dhruvasagar/vim-table-mode' " plain-text table formatting
Plugin 'Raimondi/delimitMate' " autobrackets
Plugin 'mhinz/vim-hugefile' " better handling of large files
Plugin 'terryma/vim-expand-region' " region expansion
Plugin 'tomtom/tcomment_vim.git' " fast commenting
Plugin 'Lokaltog/vim-easymotion' " fast motion
Plugin 'danro/rename.vim'
Plugin 'tpope/vim-dispatch.git' " asynchronous make
if v:version > 703 || v:version == 703 && has('patch584')
    Plugin 'Valloric/YouCompleteMe' " fast code completion
endif
Plugin 'godlygeek/tabular' " automatic alignment
Plugin 'kien/ctrlp.vim' " fuzzy file search [ctrl-p]
Plugin 'scrooloose/syntastic' " linter support
Plugin 'majutsushi/tagbar' " ctags support [ctrl-b]
Plugin 'tpope/vim-fugitive' " git support
Plugin 'airblade/vim-gitgutter' " git gutter
Plugin 'jcfaria/Vim-R-plugin' " R support
Plugin 'davidoc/taskpaper.vim' " taskpaper support
Plugin 'othree/html5.vim' " html5 support
Plugin 'pangloss/vim-javascript' " javascript support
Plugin 'mattn/webapi-vim' " supports web apis
Plugin 'mattn/gist-vim' " gist support
" Plugin 'LaTeX-Box-Team/LaTeX-Box' " latex suport
Plugin 'lervag/vimtex' " latex support
Plugin 'JuliaLang/julia-vim' " julia support
" Plugin 'hdima/python-syntax' " better python syntax
Plugin 'klen/python-mode'  " python support
Plugin 'plasticboy/vim-markdown' " markdown support
Plugin 'ryanss/vim-hackernews' " hackernews

call vundle#end()

set omnifunc=syntaxcomplete#Complete
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_semantic_triggers = {
            \  'tex'  : ['{', 're!\\cite\{.*,'],
            \ }

nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>f :CtrlPLine<CR>
let g:ctrlp_follow_symlinks = 2
let g:ctrlp_user_command = 'ag %s -l -g ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

vnoremap <C-K> y:Ag\ "<C-R><C-R>""<CR>
vnoremap <Leader>kf y:Ag\ "<C-R><C-R>"" --fortran<CR>
nnoremap \ :Ag<SPACE>"
nnoremap <Leader>q :cclose<CR>:lclose<CR>
set grepprg=ag\ --nogroup\ --nocolor

let g:vimtex_quickfix_ignored_warnings = [
            \ 'Underfull', 'Overfull', 'specifier changed to',
            \ "'babel/polyglossia' detected",
            \ "Token not allowed in a PDF string",
            \ "unicode-math warning",
            \ "Marginpar"
            \ ]

nnoremap <Leader>mk :Make<CR>

let g:vimtex_fold_enabled = 0

let g:gitgutter_max_signs = 10000

let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvqxyz'
let g:EasyMotion_startofline = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_target_hl_inc_cursor = 3
map s <Plug>(easymotion-f2)
map S <Plug>(easymotion-F2)
map m <Leader><Leader>w
map M <Leader><Leader>b

let g:syntastic_auto_jump = 2
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_python_checkers = ['flake8', 'pep257']
let g:syntastic_python_pep257_args = ['--ignore=D100,D101,D102,D103']
let g:syntastic_python_flake8_args = ['--ignore=E501,E226']
let g:syntastic_python_flake8_quiet_messages =  {
            \ "regex": [
            \    "undefined name 'basestring'",
            \    "undefined name 'unicode'"
            \ ]}
let g:syntastic_fortran_checkers = ['gfortran']
let g:syntastic_fortran_compiler_options = '-ffree-line-length-none'
let g:syntastic_html_checkers = ['w3']
let g:syntastic_javascript_checkers = ['jshint']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnametruncate = 17

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  let a:palette.tabline = {}
  let a:palette.tabline.airline_tabsel = [0, 0, 8, 2]
  let a:palette.tabline.airline_tab = [0, 0, 2, 16]
  let a:palette.tabline.airline_tabmod = [0, 0, 8, 1]
  let a:palette.tabline.airline_tabmod_unsel = [0, 0, 1, 16]
  let a:palette.tabline.airline_tabhid = [0, 0, 8, 16]
  let l:green = airline#themes#generate_color_map(
              \ [0, 0, 8, 2], [0, 0, 8, 2], [0, 0, 16, 16])
  let l:red = airline#themes#generate_color_map(
              \ [0, 0, 8, 1], [0, 0, 8, 1], [0, 0, 16, 16])
  let l:blue = airline#themes#generate_color_map(
              \ [0, 0, 8, 4], [0, 0, 8, 4], [0, 0, 16, 16])
  let l:gray = airline#themes#generate_color_map(
              \ [0, 0, 16, 8], [0, 0, 16, 8], [0, 0, 16, 8])
  let a:palette.normal = l:green
  let a:palette.normal_modified = l:red
  let a:palette.normal_paste = l:blue
  let a:palette.insert = l:green
  let a:palette.insert_modified = l:red
  let a:palette.insert_paste = l:blue
  let a:palette.visual = l:green
  let a:palette.visual_modified = l:red
  let a:palette.visual_paste = l:blue
  let a:palette.inactive = l:gray
  let a:palette.inactive_modified = l:gray
  let a:palette.inactive_paste = l:gray
endfunction

let g:task_paper_styles ={ 
            \    'flagged': 'ctermfg=Red guifg=Red',
            \    'due': 'ctermfg=Yellow guifg=Yellow',
            \    'waiting': 'ctermfg=Green guifg=Green',
            \ }

let g:pymode_lint = 0 " we do this with syntastic
let g:pymode_rope = 0 " this is done by youcompleteme
let g:pymode_folding = 0

let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
let g:tagbar_autopreview = 1
let g:tagbar_compact = 1
let g:tagbar_width = 35
let g:tagbar_previewwin_pos = 'abo'
nnoremap <Leader>t :TagbarToggle<CR>

let vimrplugin_vsplit = 1
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

vmap v <Plug>(expand_region_expand)
vmap <Leader>v <Plug>(expand_region_shrink)

if filereadable("~/.vimrc_local")
    so ~/.vimrc_local
endif
