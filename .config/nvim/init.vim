" vim: set foldmethod=marker foldlevel=0:

" Options {{{
" ===========

set clipboard=unnamed
set completeopt-=preview
set diffopt+=iwhite
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
set shortmess+=s
set showmatch
set smartcase
set smartindent
set softtabstop=4
set tabstop=4
set timeoutlen=500
set title
set visualbell
set wrap
if has('persistent_undo')
    set undofile
endif
if has('nvim')
    set inccommand=split
endif

" }}}

" Basics {{{
" ======

if filereadable($XDG_CONFIG_HOME . '/nvim/local.init.vim')
    execute 'source ' . $XDG_CONFIG_HOME . '/nvim/local.init.vim'
endif

let g:loaded_python_provider = 1
let g:python3_host_skip_check = 1

augroup restore_cursor
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe ":normal! g`\"" | endif
augroup END

if has('macunix')
    let g:clipboard = {
                \ 'name': 'macos-clipboard',
                \ 'copy': {'+': 'pbcopy', '*': 'pbcopy'},
                \ 'paste': {'+': 'pbpaste', '*': 'pbpaste'},
                \ 'cache_enabled': 0,
                \ }
endif

" }}}

" Key mappings {{{
" ============

let mapleader = ' '
let maplocalleader = ' '

" Vanilla Vim mappings {{{
" --------------------
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <silent> <Leader>d :Bdelete<CR>
nnoremap <silent> <Leader>q :bprevious<CR>
nnoremap <silent> <Leader>w :bnext<CR>
nnoremap <silent> <Leader>n :nohlsearch<CR>
nnoremap <silent> <Leader>a :Loc<CR>
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
if has('nvim') || has('terminal')
    tnoremap <C-X> <C-\><C-n>
    tnoremap <C-H> <C-\><C-n><C-W>h
    tnoremap <C-J> <C-\><C-n><C-W>j
    tnoremap <C-K> <C-\><C-n><C-W>k
    tnoremap <C-L> <C-\><C-n><C-W>l
endif
if has('nvim')
    nnoremap <silent> <Leader>1 :belowright 15split<CR>:terminal<CR>
elseif has('terminal')
    nnoremap <silent> <Leader>1 :terminal<CR>
endif

command -bang -nargs=? Loc call LocToggle(<bang>0)

function! LocToggle(forced)
    if exists("g:loc_win") && a:forced == 0
        lclose
        unlet g:loc_win
    else
        lopen 10
        let g:loc_win = bufnr("$")
    endif
endfunction
" }}}

" Plugin mappings {{{
" ---------------
nnoremap <Leader>mk :Neomake!<CR>
xmap ga <Plug>(EasyAlign)
nnoremap \\ :BLines<Space>
nnoremap \ :Rg<Space>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Space>f :BLines<CR>
nnoremap <silent> <Space>F :Rg<CR>
nnoremap <silent> <Leader>t :BTags<CR>
nnoremap <silent> <Leader>T :Tags<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
vnoremap <silent> <Leader>ldf :Linediff<CR>
nnoremap <silent> <Leader>ldf :LinediffReset<CR>
nnoremap <silent> <Leader>go :Goyo<CR>
" }}}

" }}}

" Session management {{{
" ==================

function! FindProjectName()
    return substitute(getcwd(), '/', '%', 'g')
endfunction

function! RestoreSession(name)
    if exists('g:my_vim_from_stdin') | return | endif
    if filereadable($XDG_DATA_HOME . '/nvim/sessions/' . a:name)
        execute 'source ' . $XDG_DATA_HOME . '/nvim/sessions/' . fnameescape(a:name)
    endif
endfunction

function! SaveSession(name)
    cclose
    lclose
    if exists('g:my_vim_from_stdin') || getcwd() == $HOME | return | endif
    execute 'mksession! ' . $XDG_DATA_HOME . '/nvim/sessions/' . fnameescape(a:name)
endfunction

if argc() == 0 && v:version >= 704
    augroup session_handler
        autocmd!
        autocmd StdinReadPre * let g:my_vim_from_stdin = 1
        autocmd VimLeave * Goyo!
        autocmd VimLeave * call SaveSession(FindProjectName())
        autocmd VimEnter * nested call RestoreSession(FindProjectName())
    augroup END
end

" }}}

" Plugin management {{{
" =================

" download vim-plug automatically if missing
if !filereadable($XDG_DATA_HOME . "/nvim/site/autoload/plug.vim")
    call system("curl -fkLo " . $XDG_DATA_HOME
                \ . "/nvim/site/autoload/plug.vim --create-dirs "
                \ . "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    autocmd VimEnter * silent! PlugInstall
endif

filetype off

call plug#begin($XDG_DATA_HOME . '/nvim/plugged')

" Colors {{{
" ------
Plug 'chriskempson/base16-vim' " base16 for gvim
" }}}

" Vanilla Vim enhancements {{{
" ------------------------
Plug 'moll/vim-bbye'                    " layout stays as is on buffer close
Plug 'rickhowe/diffchar.vim'
Plug 'tpope/vim-repeat'                 " makes . accessible to plugins
" }}}

" New functionality {{{
" -----------------
Plug 'AndrewRadev/linediff.vim'         " diffing ranges, key: <Leader>ldf
Plug 'bronson/vim-trailing-whitespace'  " trailing whitespace
Plug 'itchyny/lightline.vim'            " fast status line
Plug 'junegunn/fzf.vim'                 " useful commands using FZF
Plug 'junegunn/goyo.vim'                " distraction-free vim, key: <Leader>go
Plug 'junegunn/limelight.vim'           " dim surrounding paragrpahs
Plug 'junegunn/vim-easy-align'          " tables in vim
Plug 'justinmk/vim-sneak'               " additional movements
Plug 'mhinz/vim-signify'                " git changes
Plug 'neomake/neomake'                  " async make/linters
Plug 'reedes/vim-pencil'                " handle single-line paragraphs
Plug 'terryma/vim-expand-region'        " expand selection key: +/_
Plug 'terryma/vim-multiple-cursors'     " key: <C-N> <C-X> <C-P>
Plug 'tommcdo/vim-exchange'             " exchange motion: cx
Plug 'tomtom/tcomment_vim'              " automatic comments, key: gc
Plug 'tpope/vim-fugitive'               " heavy plugin, provides :Gblame
Plug 'tpope/vim-surround'               " key: cs, ds, ys
Plug 'wellle/targets.vim'               " extra motion targets
Plug 'w0rp/ale'
if v:version >= 704
    Plug 'bling/vim-bufferline'         " show open buffers in command line
endif
if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
elseif v:version >= 800 && has("python3")
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" }}}

" File-type plugins {{{
" -----------------
Plug 'chikamichi/mediawiki.vim'         " wiki file format
Plug 'chrisbra/csv.vim'
Plug 'igordejanovic/textx.vim'
Plug 'plasticboy/vim-markdown'
Plug 'sheerun/vim-polyglot'
Plug 'zchee/deoplete-jedi'
" }}}

call plug#end()

filetype plugin indent on

" }}}

" File-type settings {{{
" ==================

let python_highlight_all = 1
let g:pyindent_open_paren = '&sw'
let g:tex_flavor = 'latex'

augroup file_types
    autocmd!
    autocmd BufEnter /private/tmp/crontab.* setl bkc=yes
    autocmd BufEnter term://* startinsert
    autocmd BufRead,BufNewFile *.pyi setl ft=python
    autocmd BufRead,BufNewFile *.pyx setl ft=cython
    autocmd FileType cpp setl cc=80 tw=80 fo=croqw cino+="(0"
    autocmd FileType fortran setl cc=80,133 tw=80 com=:!>,:! fo=croq nu
    autocmd FileType javascript setl cc=80 nu
    autocmd FileType javascript setl ts=2 sw=2 sts=2
    autocmd FileType markdown setl tw=80 spell ci pi sts=0 sw=4 ts=4
    autocmd FileType mediawiki setl tw=80 spell ci pi sts=0 sw=4 ts=4
    autocmd FileType python setl nosi cc=80 tw=80 fo=croq nu cino+="(0"
    autocmd FileType rst setl spell | syn spell toplevel
    autocmd FileType tex setl tw=80 ts=2 sw=2 sts=2 spell
    autocmd FileType yaml setl ts=2 sw=2 sts=2
augroup END

" }}}

" Color theme {{{
" ===========

function! s:patch_base16_colors()
    hi Normal ctermbg=none
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellLocal
    hi SpellBad ctermbg=1
    hi SpellCap ctermbg=1
    hi SpellLocal ctermbg=1
endfunction

autocmd! ColorScheme base16-default-dark call s:patch_base16_colors()

try
    colorscheme base16-default-dark
catch /^Vim\%((\a\+)\)\=:E185/  " catch error when theme not installed
endtry

" }}}

" Plugin configuration {{{
" ====================

" Polyglot {{{
" --------
let g:polyglot_disabled = ['latex']
" }}}

" Vim Markdown {{{
" ------------
let g:vim_markdown_fenced_languages = ['python=python']
" }}}

" FZF {{{
" ---
let g:fzf_tags_command = 'rg -l "" | ctags --fortran-kinds=-l -L -'
" }}}

" Limelight {{{
" ---------
let g:limelight_conceal_ctermfg = 13
" }}}

" ALE {{{
" ---
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_fix_on_save = 1
" }}}

" Signify {{{
" -------
let g:signify_vcs_list = ['git', 'hg']
let g:signify_sign_add = '∙'
let g:signify_sign_change = '∙'
" }}}

" Bufferline {{{
" ----------
let g:bufferline_modified = '❌ '
let g:bufferline_active_buffer_left = '📝 '
let g:bufferline_active_buffer_right = ''
let g:bufferline_rotate = 1
" }}}

" Lightline {{{
" ---------
let g:lightline = {
		    \     'active': {
		    \         'left': [[ 'mode', 'paste' ],
		    \                  [ 'filename', 'modified' ]],
		    \         'right': [[ 'lineinfo' ],
		    \                   [ 'percent' ],
		    \                   [ 'fileformat', 'fileencoding', 'filetype' ]]
            \     },
            \     'colorscheme': 'jellybeans',
            \     'component': {'lineinfo': ' %3l:%-2v'},
            \     'component_function': {'modified': 'LightLineModified'},
            \     'separator': {'left': '', 'right': ''},
            \     'subseparator': {'left': '', 'right': ''}
            \ }

function! LightLineModified()
    return &modified ? '❌' : &readonly ? '🔒' : '✅'
endfunction
" }}}

" Multiple Cursors {{{
" ----------------
let g:multi_cursor_exit_from_insert_mode = 0

function g:Multiple_cursors_before()
    call deoplete#custom#buffer_option('auto_complete', v:false)
    execute "ALEDisable"
endfunction

function g:Multiple_cursors_after()
    call deoplete#custom#buffer_option('auto_complete', v:true)
    execute "ALEEnable"
endfunction
" }}}

" Sneak {{{
" -----
let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

highlight SneakStreakMask ctermfg=8
highlight clear SneakStreakStatusLine
" }}}

" Pencil {{{
" ------
let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0
augroup pencil_types
    autocmd!
    autocmd FileType markdown call pencil#init()
    autocmd FileType mediawiki call pencil#init()
    autocmd FileType tex call pencil#init()
    autocmd FileType rst call pencil#init()
    autocmd FileType text call pencil#init()
augroup END
" }}}

" Deoplete {{{
" --------
if exists("*deoplete#custom#set")
    let g:deoplete#omni#input_patterns = {}
    autocmd InsertEnter * call deoplete#enable()
    call deoplete#custom#set('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])
endif
if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns = {}
endif
" }}}

" Goyo {{{
" ----
let g:goyo_width = 75

function! s:goyo_enter()
    set noshowcmd
    set scrolloff=999
    Limelight
    au! bufferline
    au! CursorHold * echo ''
endfunction

function! s:goyo_leave()
    set showcmd
    set scrolloff=1
    Limelight!
    call bufferline#init_echo()
endfunction

augroup pencil
    autocmd!
    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END
" }}}

" }}}
