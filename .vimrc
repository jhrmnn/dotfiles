filetype plugin indent on
syntax on

set background=dark
set wildmenu
set backspace=indent,eol,start
set gdefault
set encoding=utf-8 nobomb
set exrc
set hlsearch incsearch
set ignorecase smartcase
set diffopt+=iwhite
set mouse=a
set clipboard=unnamed
set noshowmode
set showmatch
set title
set autoindent smartindent smarttab
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround
set wrap linebreak nolist
set viminfo='100,<100,:100,n~/.viminfo
set undofile
set nofoldenable
set laststatus=2
set noerrorbells visualbell t_vb=
set sessionoptions-=options
let g:tex_flavor = "latex"
if v:version > 704 || v:version == 704 && has('patch338')
    set breakindent breakindentopt=shift:2
    let &showbreak = '> '
endif

highlight Normal ctermbg=none
highlight ColorColumn ctermbg=8

let mapleader = ' '
let maplocalleader = ' '

nnoremap <Leader>T :enew<CR>
nnoremap <Leader><tab> :bnext!<CR>
nnoremap <Leader><s-tab> :bprevious!<CR>
nnoremap <Leader>w :bdelete<CR>
nnoremap <Leader>i :set invpaste<CR>
noremap <BS> :noh<CR>
nnoremap <Leader>q :cclose<CR>:lclose<CR>
nnoremap <S-Enter> O
nnoremap <Enter> o

autocmd FileType fortran setlocal cc=80 comments=:!>,:! tw=80 fo=cqroanw2 number
autocmd BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
autocmd BufRead,BufNewFile *.f90 let b:fortran_more_precise=1
autocmd FileType python setlocal cc=80 fo=cqroanw tw=79 number cino+=(0
autocmd FileType javascript setlocal cc=80 number
autocmd FileType cpp setlocal cc=80 tw=80 fo=cqroanw number cino+=(0
autocmd FileType mkd setlocal tw=80 fo=wnb1vb spell noet ci pi sts=0 sw=4 ts=4
autocmd FileType tex setlocal tw=80 fo=tcqroaw1 number ts=2 sw=2 sts=2 spell
autocmd FileType tex syntax spell toplevel
autocmd FileType yaml setlocal ts=2 sw=2 sts=2

autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \     exe ":normal! g`\"" |
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

"" settings below concerns plugins

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" improving plugins
Plugin 'Shougo/vimproc' " makes some plugins faster
Plugin 'tpope/vim-repeat' " makes . accessible for plugins
Plugin 'moll/vim-bbye' " layout stays as is on buffer close
Plugin 'mattn/webapi-vim'
Plugin 'junegunn/fzf'
Plugin 'rking/ag.vim'
Plugin 'Raimondi/delimitMate' " automatic closing of paired delimiters
Plugin 'mhinz/vim-hugefile'

" new functionality
Plugin 'chriskempson/base16-vim' " base16 for gvim
Plugin 'bling/vim-airline' " status and buffer line
Plugin 'scrooloose/syntastic' " linters in vim
Plugin 'majutsushi/tagbar' " ctags
Plugin 'tpope/vim-fugitive' " git
Plugin 'airblade/vim-gitgutter'
Plugin 'klen/python-mode'
Plugin 'plasticboy/vim-markdown'
Plugin 'jcfaria/Vim-R-plugin'
Plugin 'davidoc/taskpaper.vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/gist-vim'
Plugin 'lervag/vimtex'
Plugin 'JuliaLang/julia-vim'

" new key commands
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'terryma/vim-expand-region'
Plugin 'tomtom/tcomment_vim.git' " automatic comments
Plugin 'justinmk/vim-sneak' " 2-letter f
Plugin 'tpope/vim-dispatch.git' " asynchronous make
Plugin 'AndrewRadev/linediff.vim' " diffing ranges

if $VIM_NO_YCM != '1' && (v:version > 703 || v:version == 703 && has('patch584'))
    Plugin 'Valloric/YouCompleteMe' " fast code completion
endif

call vundle#end()

filetype plugin indent on

set omnifunc=syntaxcomplete#Complete
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_semantic_triggers = {
            \  'tex'  : ['{', 're!\\cite\{.*,'],
            \ }

nnoremap <Leader>p :FZF<CR>

vnoremap <Leader>ldf :Linediff<CR>
nnoremap <Leader>ldf :LinediffReset<CR>

let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'

vnoremap <C-K> y:Ag\ "<C-R><C-R>""<CR>
nnoremap \ :Ag<SPACE>"
set grepprg=ag\ --nogroup\ --nocolor

let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_ignored_warnings = [
            \ 'Underfull', 'Overfull', 'specifier changed to',
            \ "'babel/polyglossia' detected",
            \ "Token not allowed in a PDF string",
            \ "unicode-math warning",
            \ "Marginpar",
            \ "Package hyperref Warning: Rerun to get /PageLabels entry."
            \ ]

nnoremap <Leader>mk :Make<CR>

let g:gitgutter_max_signs = 10000

let g:sneak#s_next = 1
let g:sneak#streak = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
omap f <Plug>Sneak_f
omap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T
omap t <Plug>Sneak_t
omap T <Plug>Sneak_T

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
let g:syntastic_tex_chktex_args = ['--nowarn 3']
let g:syntastic_html_checkers = ['w3']
let g:syntastic_javascript_checkers = ['jshint']

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnametruncate = 17

let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
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
  let a:palette.tabline = {}
  let a:palette.tabline.airline_tabsel = [0, 0, 8, 2]
  let a:palette.tabline.airline_tab = [0, 0, 2, 16]
  let a:palette.tabline.airline_tabmod = [0, 0, 8, 1]
  let a:palette.tabline.airline_tabmod_unsel = [0, 0, 1, 16]
  let a:palette.tabline.airline_tabhid = [0, 0, 8, 16]
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
