filetype plugin indent on
syntax on

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
set pastetoggle=<F9>
set mouse=a
set timeoutlen=500
set clipboard=unnamed
set noshowmode
set showmatch
set display+=lastline
set title
set autoread
set history=1000
set scrolloff=1
set autoindent smartindent smarttab
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround
set wrap linebreak nolist
set undofile
set nofoldenable
set laststatus=2
set noerrorbells visualbell t_vb=
set omnifunc=syntaxcomplete#Complete
set sessionoptions-=options

highlight Normal ctermbg=none
highlight ColorColumn ctermbg=8

let mapleader = " "
let maplocalleader = " "

vmap <Tab> <Plug>(expand_region_expand)
vmap <S-Tab> <Plug>(expand_region_shrink)
vnoremap <F9> ~
nnoremap <BS> <C-O>
vnoremap \ y:Ag!<Space>"<C-R><C-R>""<CR>
nnoremap \ :Ag!<Space>""<left>
nnoremap <F4> :bnext!<CR>
nnoremap <F3> :bprevious!<CR>
nnoremap é :bnext!<CR>
nnoremap í :bprevious!<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :Bdelete<CR>
nnoremap <Leader>e :edit<Space>
nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>s :OverCommandLine<CR>%s/
vnoremap <Leader>s :OverCommandLine<CR>s/
nnoremap <Leader>f :FZFLinesBuffer<CR>
nnoremap <Leader>; :cclose<CR>:lclose<CR>:pclose<CR>
" nnoremap <Leader>t :TagbarToggle<CR>
nnoremap <Leader>p :FZF<CR>
nnoremap <Leader>mk :Make<CR>
nnoremap <Leader>gf :FZFLines<CR>
nnoremap <Leader>ggf :FZFLinesAll<CR>
nnoremap <Leader>t :FZFTagsBuffer<CR>
nnoremap <Leader>gt :FZFTags<CR>
nnoremap <Leader>T :call<Space>MakeTags()<CR>
vnoremap <Leader>ldf :Linediff<CR>
nnoremap <Leader>ldf :LinediffReset<CR>
nnoremap <Leader>go :Goyo<CR>
" windows movements
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

autocmd FileType fortran setlocal cc=80 tw=80 comments=:!>,:! fo=croqwa number
autocmd BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
autocmd BufRead,BufNewFile *.f90 let b:fortran_more_precise=1
autocmd FileType python setlocal cc=80 tw=79 fo=croqa number cino+=(0
autocmd FileType javascript setlocal cc=80 number
autocmd FileType cpp setlocal cc=80 tw=80 fo=croqwa number cino+=(0
autocmd FileType markdown setlocal tw=80 spell noet ci pi sts=0 sw=4 ts=4
autocmd FileType tex setlocal tw=80 ts=2 sw=2 sts=2 spell
autocmd FileType yaml setlocal ts=2 sw=2 sts=2
autocmd BufRead,BufNewFile *.pyx set filetype=cython

" restore position in a buffer
autocmd BufReadPost *
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \     exe ":normal! g`\"" |
            \ endif

function! FindProjectName()
    let s:name = fnamemodify(getcwd(), ":t") . "." . 
                \ md5#md5(getcwd()) . ".vim"
    return s:name
endfunction

function! MakeTags()
    echo 'Preparing tags...'
    call system('ctags -R')
    echo 'Tags done'
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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" new functionality
Plugin 'terryma/vim-multiple-cursors' "key: <C-N> <C-X> <C-P>
Plugin 'tpope/vim-surround' " key: cs, ds, ys
Plugin 'terryma/vim-expand-region' " key: <Tab>
Plugin 'tomtom/tcomment_vim.git' " automatic comments, key: gc
Plugin 'tyru/open-browser.vim' " key: gx
Plugin 'justinmk/vim-sneak' " 2-letter f, key: s S f t
Plugin 'rking/ag.vim' " silver searcher, key: \
Plugin 'tpope/vim-dispatch.git' " asynchronous make, key: <Leader>mk
Plugin 'osyo-manga/vim-over' " better substitute, key: <Leader>s
Plugin 'junegunn/goyo.vim' " distraction-free vim, key: <Leader>go
Plugin 'AndrewRadev/linediff.vim' " diffing ranges, key: <Leader>ldf
Plugin 'junegunn/fzf' " key: <Leader>p
Plugin 'tpope/vim-fugitive' " git
" automatic functionality
Plugin 'chriskempson/base16-vim' " base16 for gvim
Plugin 'bling/vim-airline' " status and buffer line
Plugin 'scrooloose/syntastic' " linters in vim
Plugin 'reedes/vim-pencil' " vim for prose
Plugin 'Raimondi/delimitMate' " automatic closing of paired delimiters
Plugin 'luochen1990/rainbow' " rainbow parentheses
Plugin 'tshirtman/vim-cython'
Plugin 'airblade/vim-gitgutter'
Plugin 'klen/python-mode'
Plugin 'hdima/python-syntax'
Plugin 'tpope/vim-markdown'
Plugin 'jcfaria/Vim-R-plugin'
Plugin 'davidoc/taskpaper.vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mattn/gist-vim'
Plugin 'lervag/vimtex'
Plugin 'JuliaLang/julia-vim'
if $VIM_NO_YCM != '1' && (v:version > 703 || v:version == 703 && has('patch584'))
    Plugin 'Valloric/YouCompleteMe' " fast code completion
endif
" helper plugins
Plugin 'Shougo/vimproc' " makes some plugins faster
Plugin 'tpope/vim-repeat' " makes . accessible for plugins
Plugin 'moll/vim-bbye' " layout stays as is on buffer close
Plugin 'mattn/webapi-vim'
Plugin 'mhinz/vim-hugefile'

call vundle#end()

filetype plugin indent on

" global variables

let g:goyo_width = 81
let g:goyo_height = '100%'
autocmd! User GoyoLeave
autocmd User GoyoLeave nested set background=dark
autocmd User GoyoLeave nested syntax off
autocmd User GoyoLeave nested syntax on
autocmd User GoyoLeave nested AirlineRefresh

let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0
augroup pencil
  autocmd!
  autocmd FileType markdown call pencil#init()
  autocmd FileType tex call pencil#init()
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
            \    'ctermfgs': ['red', 'yellow', 'green', 'blue'],
            \    'separately': {
            \         'sh': {
            \              'parentheses': ['start=/\[\[/ end=/\]\]/',
            \                              'start=/((/ end=/))/']
            \         }
            \     }
            \ }

" let g:tagbar_autoclose = 1
" let g:tagbar_autofocus = 1
" let g:tagbar_compact = 1
" let g:tagbar_width = 35
" let g:tagbar_sort = 0

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_semantic_triggers = {
            \  'tex'  : ['{', 're!\\cite\{.*,'],
            \ }

let g:syntastic_auto_jump = 2
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_python_checkers = ['flake8', 'pep257']
let g:syntastic_python_pep257_args = ['--ignore=D100,D101,D102,D103']
let g:syntastic_python_flake8_args = ['--ignore=E501,E226']
let g:syntastic_python_flake8_quiet_messages = {
            \ "regex": [
            \    "undefined name 'basestring'",
            \    "undefined name 'unicode'"
            \ ]}
let g:syntastic_fortran_checkers = ['gfortran']
let g:syntastic_fortran_compiler_options = '-ffree-line-length-none'
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
            \ "Package hyperref Warning: Rerun to get /PageLabels entry."
            \ ]

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnametruncate = 17
let g:airline_theme_patch_func = 'AirlineThemePatch'

function! AirlineThemePatch(palette)
  let l:green = airline#themes#generate_color_map([0, 0, 8, 2], [0, 0, 8, 2], [0, 0, 16, 16])
  let l:red = airline#themes#generate_color_map([0, 0, 8, 1], [0, 0, 8, 1], [0, 0, 16, 16])
  let l:blue = airline#themes#generate_color_map([0, 0, 8, 4], [0, 0, 8, 4], [0, 0, 16, 16])
  let l:gray = airline#themes#generate_color_map([0, 0, 16, 8], [0, 0, 16, 8], [0, 0, 16, 8])
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

command! FZFLinesAll call fzf#run({
            \   'source': 'ag .',
            \   'sink': function('<sid>line_handler'),
            \   'options': '--nth=3..'
            \ })

command! FZFLines call fzf#run({
            \   'source': 'ag . ' . join(map(filter(range(0, bufnr("$")), 
            \              "buflisted(v:val)"), "bufname(v:val)")),
            \   'sink': function('<SID>line_handler'),
            \   'options': '--nth=3..'
            \ })

function! s:line_handler(l)
    let keys = split(a:l, ':')
    exec 'edit' keys[0]
    exec keys[1]
endfunction

command! FZFLinesBuffer call fzf#run({
            \   'source': 'ag . ' . bufname(""),
            \   'sink': function('<SID>buff_line_handler'),
            \   'options': '--nth=2..'
            \ })

function! s:buff_line_handler(l)
    let keys = split(a:l, ':')
    exec keys[0]
endfunction

command! -bar FZFTags if !empty(tagfiles()) | 
            \ call fzf#run({
            \   'source': 'gsed ''/^\\!/ d; s/^\([^\t]*\)\t.*\t\(\w\)\(\t.*\)\?/\2\t\1/; /^l/ d'' ' . join(tagfiles()) . ' | uniq',
            \   'sink': function('<SID>tag_line_handler'),
            \ }) | else | call MakeTags() | FZFTags | endif


command! FZFTagsBuffer call fzf#run({
            \   'source': 'ctags -f - --sort=no ' . bufname("") . ' | gsed ''s/^\([^\t]*\)\t.*\t\(\w\)\(\t.*\)\?/\2\t\1/'' | sort -k 1.1,1.1 -s',
            \   'sink': function('<SID>tag_line_handler'),
            \   'options': '--tac',
            \ })

function! s:tag_line_handler(l)
    let keys = split(a:l, '\t')
    exec 'tag' keys[1]
endfunction
