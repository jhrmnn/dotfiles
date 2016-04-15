filetype plugin indent on
syntax on

set shell=/bin/bash
set nocompatible
set background=dark
set wildmenu
set backspace=indent,eol,start
set gdefault
set encoding=utf-8 nobomb
set exrc
set hlsearch incsearch
set ignorecase smartcase
set diffopt+=iwhite
set shortmess+=s
set hidden
set pastetoggle=<F10>
set mouse=a
set timeoutlen=500
set clipboard=unnamed
set noshowmode
set modelines=10
set showmatch
set display+=lastline
set title
set titleold=
set autoread
set history=1000
set scrolloff=1
set autoindent smartindent smarttab
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround
set wrap linebreak nolist
set undofile
set undodir=$HOME/.vim/undo 
set nofoldenable
set laststatus=2
set noerrorbells visualbell t_vb=
set omnifunc=syntaxcomplete#Complete
set sessionoptions-=options

if !empty($TMUX)
    set t_ts=Ptmux;]2;
    set t_fs=\
endif

let mapleader = " "
let maplocalleader = " "

vmap <Tab> <Plug>(expand_region_expand)
vmap <S-Tab> <Plug>(expand_region_shrink)
vnoremap <F9> ~
nnoremap é :bnext<CR>
nnoremap í :bprevious<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :Bdelete<CR>
nnoremap <Leader>+ :silent !tmux split-window -v -p 25<CR>
nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>; :cclose<CR>:lclose<CR>:pclose<CR>
nnoremap <Leader>, <F10>
nnoremap <Leader>d :call ToggleFold()<CR>
nnoremap <Leader>p :FZF<CR>
nnoremap \\ :FZFLinesBuffer<Space>
nnoremap \ :FZFLinesAll<Space>
vnoremap \\ y:FZFLinesBuffer<Space><C-R><C-R>"<CR>
vnoremap \ y:FZFLinesAll<Space><C-R><C-R>"<CR>
xmap ga <Plug>(EasyAlign)
nnoremap <Space>f :FZFLinesBuffer<CR>
nnoremap <Space>gf :FZFLinesAll<CR>
nnoremap <Leader>t :FZFTagsBuffer<CR>
nnoremap <Leader>gt :FZFTags<CR>
nnoremap <Leader>T :call<Space>MakeTags()<CR>
nnoremap <Leader>s :OverCommandLine<CR>%s/
vnoremap <Leader>s :OverCommandLine<CR>s/
nnoremap <Leader>mk :Make<CR>
vnoremap <Leader>ldf :Linediff<CR>
nnoremap <Leader>ldf :LinediffReset<CR>
nnoremap <Leader>go :Goyo<CR>
" windows movements
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

autocmd FileType fortran setlocal cc=80,133 tw=80 comments=:!>,:! fo=croqw number
autocmd FileType python setlocal cc=80 tw=79 fo=croq number cino+=(0
autocmd FileType javascript setlocal cc=80 number
autocmd FileType cpp setlocal cc=80 tw=80 fo=croqw number cino+=(0
autocmd FileType markdown setlocal tw=80 spell ci pi sts=0 sw=4 ts=4
autocmd FileType tex setlocal tw=80 ts=2 sw=2 sts=2 spell
autocmd FileType yaml setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.pyx set filetype=cython

" restore position in a buffer
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \     exe ":normal! g`\"" |
            \ endif

function! ToggleFold()
    if &foldmethod == "manual"
        setlocal foldmethod=syntax
        echo "syntax"
    elseif &foldmethod == "syntax"
        setlocal foldmethod=manual
        echo "manual"
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

filetype off

call plug#begin('~/.vim/plugged')

" new functionality
Plug 'terryma/vim-multiple-cursors' "key: <C-N> <C-X> <C-P>
Plug 'tpope/vim-surround' " key: cs, ds, ys
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-expand-region' " key: <Tab>
Plug 'tomtom/tcomment_vim' " automatic comments, key: gc
Plug 'tyru/open-browser.vim' " key: gx
Plug 'justinmk/vim-sneak' " 2-letter f, key: s S f t
Plug 'tpope/vim-dispatch' " asynchronous make, key: <Leader>mk
Plug 'osyo-manga/vim-over' " better substitute, key: <Leader>s
Plug 'junegunn/goyo.vim' " distraction-free vim, key: <Leader>go
Plug 'AndrewRadev/linediff.vim' " diffing ranges, key: <Leader>ldf
Plug 'bronson/vim-trailing-whitespace'
Plug 'junegunn/fzf' " key: <Leader>p
Plug 'tpope/vim-fugitive' " git
Plug 'junegunn/gv.vim' " commit browser
Plug 'christoomey/vim-tmux-navigator' " tmux
Plug 'krisajenkins/vim-pipe'
" automatic functionality
Plug 'chriskempson/base16-vim' " base16 for gvim
Plug 'vim-airline/vim-airline' " status and buffer line
Plug 'vim-airline/vim-airline-themes' " status and buffer line
Plug 'scrooloose/syntastic' " linters in vim
Plug 'reedes/vim-pencil' " vim for prose
Plug 'Raimondi/delimitMate' " automatic closing of paired delimiters
Plug 'luochen1990/rainbow' " rainbow parentheses
Plug 'tshirtman/vim-cython'
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify'
Plug 'dag/vim-fish'
Plug 'klen/python-mode'
Plug 'keith/swift.vim'
Plug 'hdima/python-syntax'
" Plug 'tpope/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'jcfaria/Vim-R-plugin'
Plug 'davidoc/taskpaper.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'mattn/gist-vim'
Plug 'lervag/vimtex'
Plug 'JuliaLang/julia-vim'
if $VIM_NO_YCM != '1' && (v:version > 703 || v:version == 703 && has('patch584'))
    Plug 'Valloric/YouCompleteMe', {'for': ['fortran', 'python', 'tex'], 'do': './install.py'} " fast code completion
    autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
endif
" helper plugins
Plug 'Shougo/vimproc', {'do': 'make'} " makes some plugins faster
Plug 'tpope/vim-repeat' " makes . accessible for plugins
Plug 'moll/vim-bbye' " layout stays as is on buffer close
Plug 'mattn/webapi-vim'
Plug 'mhinz/vim-hugefile'

call plug#end()

filetype plugin indent on

colorscheme base16-default

" global variables

let g:goyo_width = 81
let g:goyo_height = '100%'

let g:vimpipe_invoke_map = '<Leader>r'
let g:vimpipe_close_map = '<Leader>x'

function! s:goyo_enter()
    silent !tmux set status off
    set noshowmode
    set noshowcmd
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    set showmode
    set showcmd
    set background=dark
    syntax off
    syntax on
    AirlineRefresh
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0
augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
  autocmd FileType tex call pencil#init()
  autocmd FileType rst call pencil#init()
augroup END
 
let g:tex_flavor = "latex"

let g:gitgutter_max_signs = 10000

let g:multi_cursor_exit_from_insert_mode = 0

let vimrplugin_vsplit = 1

let g:sneak#s_next = 1

let g:pymode_lint = 0 " we do this with syntastic
let g:pymode_rope = 0 " this is done by youcompleteme
let g:pymode_folding = 0
let g:pymode_syntax = 0

let python_highlight_all = 1

let g:rainbow_active = 1 
let g:rainbow_conf = {
            \    'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \    'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/'],
            \    'separately': {
            \         'sh': {
            \              'parentheses': ['start=/\[\[/ end=/\]\]/',
            \                              'start=/((/ end=/))/']
            \         },
            \         'liquid': {
            \              'parentheses': ['start=/{%/ end=/%}/',
            \                              'start=/{{/ end=/}}/']
            \         }
            \     }
            \ }

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_semantic_triggers = {
            \  'tex'  : ['{', 're!\\cite\{.*,'],
            \ }

let g:pandoc#completion#bib#mode = 'citeproc'
let g:pandoc#biblio#sources = 'b'
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#syntax#codeblocks#embeds#langs = ["python"]

let g:syntastic_auto_jump = 2
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_python_checkers = ['flake8', 'pep257']
let g:syntastic_python_pep257_args = ['--ignore=D100,D101,D102,D103,D105,D203']
let g:syntastic_python_flake8_args = ['--ignore=E501,E226,E402']
let g:syntastic_python_flake8_quiet_messages = {
            \ "regex": [
            \    "undefined name 'basestring'",
            \    "undefined name 'unicode'"
            \ ]}
let g:syntastic_fortran_checkers = ['gfortran']
let g:syntastic_fortran_compiler_options = '-ffree-line-length-none -fcoarray=single -fcheck=all'
            \ . ' -fall-intrinsics'
let g:syntastic_fortran_gfortran_quiet_messages = {
            \ "regex": [
            \    "unused dummy argument 'dummy",
            \ ]}
command FortranGNU let b:syntastic_fortran_cflags = "-std=gnu"
command FortranNormal let b:syntastic_fortran_cflags = "-std=f95"
command FortranPedant let b:syntastic_fortran_cflags = 
            \ '-std=f95 -Wall -pedantic -Waliasing -Wcharacter-truncation' 
            \ . ' -Wextra -Wimplicit-procedure -Wintrinsics-std -Wsurprising'
command Fortran08 let b:syntastic_fortran_cflags = "-std=f2008"
command Fortran08Pedant let b:syntastic_fortran_cflags = 
            \ '-Wall -pedantic -Waliasing -Wcharacter-truncation' 
            \ . ' -Wextra -Wimplicit-procedure -Wintrinsics-std -Wsurprising -std=f2008'
" let g:syntastic_html_checkers = ['w3']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_tex_checkers = ['chktex']
let g:syntastic_tex_chktex_args = ['--nowarn', '29']

let g:task_paper_styles = { 
            \    'flagged': 'ctermfg=Red guifg=Red',
            \    'due': 'ctermfg=Yellow guifg=Yellow',
            \    'waiting': 'ctermfg=Green guifg=Green',
            \ }

let g:vimtex_fold_enabled = 0
let g:vimtex_quickfix_ignored_warnings = [
            \ 'Underfull', 'Overfull', 'specifier changed to',
            \ "'babel/polyglossia' detected",
            \ "Token not allowed in a PDF string",
            \ "unicode-math warning",
            \ "Marginpar",
            \ "Package hyperref Warning: Rerun to get /PageLabels entry.",
            \ "biblatex Warning: The following entry could not be found",
            \ "WARN - I didn't find a database entry",
            \ "Suppressing link with empty target",
            \ ]

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnametruncate = 17

command! -nargs=? FZFLinesAll call fzf#run({
            \   'source': printf('ag --nogroup --column --color "%s"', 
            \         escape(empty('<args>') ? '^(?=.)' : '<args>', '"\-')),
            \   'sink*': function('s:line_handler'),
            \   'options': '--multi --ansi --delimiter :  --tac --prompt "Ag>" ' .
            \         '--bind ctrl-a:select-all,ctrl-d:deselect-all -n 1,4.. --color'
            \ })

function! s:ag_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': &acd ? fnamemodify(parts[0], ':p') : parts[0], 
                \ 'lnum': parts[1], 
                \ 'col': parts[2],
                \ 'text': join(parts[3:], ':')}
endfunction

function! s:line_handler(lines)
    if len(a:lines) == 0
        return
    endif
    let list = map(a:lines, 's:ag_to_qf(v:val)')
    exec 'edit' list[0].filename
    exec list[0].lnum
    exec 'normal!' list[0].col . '|zz'
    if len(a:lines) > 1
        call setqflist(reverse(list))
        botright copen
    endif
endfunction

command! -nargs=? FZFLinesBuffer call fzf#run({
            \   'source': printf('ag --nogroup --column --color "%s" %s', 
            \        escape(empty('<args>') ? '^(?=.)' : '<args>', '"\-'), bufname("")),
            \   'sink*': function('s:buff_line_handler'),
            \   'options': '--multi --ansi --delimiter :  --tac --prompt "Ag>" ' .
            \         '--bind ctrl-a:select-all,ctrl-d:deselect-all -n 1,3.. --color'
            \ })

function! s:buff_ag_to_qf(line)
    let parts = split(a:line, ':')
    return {'filename': bufname(""), 
                \ 'lnum': parts[0], 'col': parts[1], 'text': join(parts[2:], ':')}
endfunction

function! s:buff_line_handler(lines)
    if len(a:lines) == 0
        return
    endif
    let list = map(a:lines, 's:buff_ag_to_qf(v:val)')
    exec list[0].lnum
    exec 'normal!' list[0].col . '|zz'
    if len(a:lines) > 1
        call setqflist(reverse(list))
        botright copen
    endif
endfunction

function! MakeTags()
    echo 'Preparing tags...'
    call system('ctags -R')
    echo 'Tags done'
endfunction

command! -bar FZFTags if !empty(tagfiles()) | call fzf#run({
            \   'source': 'gsed ''/^\\!/ d; s/^\([^\t]*\)\t\([^\t]*\)\t\(.*;"\)\t\(\w\)\t\?\([^\t]*\)\?/\4\t|..|\1\t|..|\2\t|..|\5|..|\3/; /^l/ d'' ' 
            \              . join(tagfiles()) . ' | column -t -s $''\t'' | gsed ''s/|..|/\t/g''',
            \   'options': '-d "\t" -n 2 --with-nth 1..4',
            \   'sink': function('s:tags_sink'),
            \ }) | else | call MakeTags() | FZFTags | endif

function! s:tags_sink(line)
    execute "edit" split(a:line, "\t")[2]
    execute join(split(a:line, "\t")[4:], "\t")
endfunction

command! FZFTagsBuffer call fzf#run({
            \   'source': printf('ctags -f - --sort=no --excmd=number --language-force=%s %s', &filetype, expand('%:S')) 
            \             . ' | gsed ''/^\\!/ d; s/^\([^\t]*\)\t\([^\t]*\)\t\(.*;"\)\t\(\w\)\t\?\([^\t]*\)\?/\4\t|..|\1\t|..|\2\t|..|\5|..|\3/; /^l/ d'''
            \             . ' | column -t -s $''\t'' | gsed ''s/|..|/\t/g''',
            \   'sink': function('s:buffer_tags_sink'),
            \   'options': '-d "\t" -n 2 --with-nth 1,2,4 --tiebreak=index --tac',
            \   'down': '40%'})

function! s:buffer_tags_sink(line)
    execute join(split(a:line, "\t")[4:], "\t")
endfunction
