set clipboard=unnamed
set diffopt+=iwhite
set exrc
set secure
set gdefault
set hidden
set ignorecase
set noerrorbells
set noshowmode
set scrolloff=20
set shortmess+=s
set showmatch
set smartcase
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set shiftround
set timeoutlen=500
set title
set visualbell
set wrap
set linebreak
if has('persistent_undo')
    set undofile
endif
if has('nvim')
    set inccommand=split
endif

let g:loaded_python_provider = 1
let g:python3_host_skip_check = 1
if has('macunix')
    let g:python3_host_prog = "/opt/neovim-python/bin/python"
    if !has('nvim')
        command! -nargs=1 Py py3 <args>
        set pythonthreedll=/usr/local/Frameworks/Python.framework/Versions/3.7/Python
        set pythonthreehome=/usr/local/Frameworks/Python.framework/Versions/3.7
    endif
endif

augroup restore_cursor
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe ":normal! g`\"" | endif
augroup END

let python_highlight_all = 1
let g:pyindent_open_paren = '&sw'
let g:tex_flavor = 'latex'

if has('macunix')
    let g:clipboard = {
                \   'name': 'macos-clipboard',
                \   'copy': {
                \      '+': 'pbcopy',
                \      '*': 'pbcopy',
                \    },
                \   'paste': {
                \      '+': 'pbpaste',
                \      '*': 'pbpaste',
                \   },
                \   'cache_enabled': 0,
                \ }
endif

"""
""" bindings
"""

let mapleader = ' '
let maplocalleader = ' '

""" vanilla vim
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <silent> <Leader>d :Bdelete<CR>
nnoremap <silent> <Leader>q :bprevious<CR>
nnoremap <silent> <Leader>w :bnext<CR>
nnoremap <silent> <Leader>n :nohlsearch<CR>
nnoremap <silent> <Leader>` :cclose<CR>:lclose<CR>:pclose<CR>
nnoremap <silent> <Leader>a :Loc<CR>
nnoremap <Leader>, <F10>
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

""" plugin-related
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

"""
""" session management
"""

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

"""
""" plugins
"""

" download vim-plug automatically if missing
if !filereadable($XDG_DATA_HOME . "/nvim/site/autoload/plug.vim")
    call system("curl -fkLo " . $XDG_DATA_HOME
                \ . "/nvim/site/autoload/plug.vim --create-dirs "
                \ . "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    autocmd VimEnter * silent! PlugInstall
endif

filetype off

call plug#begin($XDG_DATA_HOME . '/nvim/plugged')

""" colors
Plug 'chriskempson/base16-vim' " base16 for gvim
""" vanilla vim enhancements
Plug 'moll/vim-bbye'                    " layout stays as is on buffer close
Plug 'tpope/vim-repeat'                 " makes . accessible to plugins
Plug 'Shougo/vimproc', {'do': 'make'}   " subprocess api for plugins
Plug 'rickhowe/diffchar.vim'
""" new functionality
" Plug 'Raimondi/delimitMate'             " automatic closing of paired delimiters
if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf'
else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'          " tables in vim
Plug 'terryma/vim-expand-region'        " expand selection key: +/_
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'               " heavy plugin, provides :Gblame
Plug 'airblade/vim-gitgutter'           " git changes
Plug 'junegunn/goyo.vim'                " distraction-free vim, key: <Leader>go
Plug 'itchyny/lightline.vim'            " fast status line
Plug 'AndrewRadev/linediff.vim'         " diffing ranges, key: <Leader>ldf
Plug 'terryma/vim-multiple-cursors'     " key: <C-N> <C-X> <C-P>
Plug 'neomake/neomake'                  " async make/linters
Plug 'reedes/vim-pencil'                " handle single-line paragraphs
Plug 'justinmk/vim-sneak'               " additional movements
Plug 'tpope/vim-surround'               " key: cs, ds, ys
Plug 'tomtom/tcomment_vim'              " automatic comments, key: gc
Plug 'bronson/vim-trailing-whitespace'  " trailing whitespace
if v:version >= 704
    Plug 'bling/vim-bufferline'         " show open buffers in command line
endif
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
elseif v:version >= 800 && has("python3")
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
""" filetype-specific
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
Plug 'chikamichi/mediawiki.vim'         " wiki file format
Plug 'chrisbra/csv.vim'
Plug 'igordejanovic/textx.vim'
Plug 'zchee/deoplete-jedi'

call plug#end()

try
    colorscheme base16-default-dark
catch /^Vim\%((\a\+)\)\=:E185/  " catch error when theme not installed
endtry

filetype plugin indent on

""" filetype autocommands
augroup file_formats
    autocmd!
    autocmd FileType fortran setl cc=80,133 tw=80 com=:!>,:! fo=croq nu
    autocmd FileType python setl nosi cc=80 tw=80 fo=croq nu cino+="(0"
    autocmd BufRead,BufNewFile *.pyi set filetype=python
    autocmd FileType javascript setl cc=80 nu
    autocmd FileType cpp setl cc=80 tw=80 fo=croqw cino+="(0"
    autocmd FileType markdown setl tw=80 spell ci pi sts=0 sw=4 ts=4
    autocmd FileType mediawiki setl tw=80 spell ci pi sts=0 sw=4 ts=4
    autocmd FileType tex setl tw=80 ts=2 sw=2 sts=2 spell
    autocmd FileType yaml setl ts=2 sw=2 sts=2
    autocmd FileType javascript setl ts=2 sw=2 sts=2
    autocmd BufRead,BufNewFile *.pyx setl ft=cython
    autocmd BufEnter /private/tmp/crontab.* setl bkc=yes
    autocmd BufEnter term://* startinsert
augroup END

"""
""" plugin configuration
"""

let g:polyglot_disabled = ['latex']

let g:vim_markdown_fenced_languages = ['python=python']

au FileType rust let b:delimitMate_quotes = "\""

let g:multi_cursor_exit_from_insert_mode = 0

let g:bufferline_modified = '❌ '
let g:bufferline_active_buffer_left = '📝 '
let g:bufferline_active_buffer_right = ''
let g:bufferline_rotate = 1

let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1

highlight SneakStreakMask ctermfg=8
highlight clear SneakStreakStatusLine

let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0
augroup pencil
    autocmd!
    autocmd FileType markdown call pencil#init()
    autocmd FileType mediawiki call pencil#init()
    autocmd FileType tex call pencil#init()
    autocmd FileType rst call pencil#init()
    autocmd FileType text call pencil#init()
augroup END

autocmd InsertEnter * call deoplete#enable()
let g:deoplete#omni#input_patterns = {}
if exists("*deoplete#custom#set")
    call deoplete#custom#set('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])
endif
if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns = {}
endif
function g:Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
endfunction
function g:Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
endfunction

let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

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

let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'

function s:fix_highlighting()
    " use terminanal background, not theme backround
    hi Normal ctermbg=none
    hi clear SpellBad
    hi clear SpellCap
    hi clear SpellLocal
    hi SpellBad ctermbg=1
    hi SpellCap ctermbg=1
    hi SpellLocal ctermbg=1
endfunction
call <SID>fix_highlighting()

let g:goyo_width = 81
let g:goyo_height = '100%'

function! s:goyo_enter()
    set noshowcmd
    au! bufferline
    au! CursorHold * echo ''
endfunction

function! s:goyo_leave()
    set showcmd
    call s:fix_highlighting()
    call bufferline#init_echo()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:fzf_tags_command = 'rg -l "" \| ctags --fortran-kinds=-l -L -<CR>'
