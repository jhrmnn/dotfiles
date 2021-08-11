" vim: set foldmethod=marker foldlevel=0:

" Options {{{
" ===========

set clipboard=unnamed
set completeopt-=preview
let &directory = $XDG_DATA_HOME . '/nvim/swap//,.'
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
let &undodir = $XDG_DATA_HOME . '/nvim/undo//'
set undofile
set visualbell
set wrap
if has('nvim')
    set diffopt+=vertical,algorithm:histogram,indent-heuristic
    set inccommand=split
endif


" }}}

" Basics {{{
" ======

colorscheme jhrmnn

let os_name = substitute(system('uname -s'), "\n", "", "")

if (os_name == "Darwin")
    let g:python3_host_prog = "/opt/pynvim/bin/python"
else
    let g:python3_host_prog = $HOME . "/opt/pynvim/bin/python"
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

nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <silent> <Leader>d :Bdelete<CR>
nnoremap <silent> <Leader>q :bprevious<CR>
nnoremap <silent> <Leader>w :bnext<CR>
nnoremap <silent> <Leader>n :nohlsearch<CR>
nnoremap <silent> <Leader>a :Loc<CR>
nnoremap <silent> <Leader>o :edit <C-R>=expand('%:p:h')<CR><CR>
vnoremap <silent> <Leader>< :diffput<CR>
vnoremap <silent> <Leader>> :diffget<CR>
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
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

command! -bang -nargs=? Loc call LocToggle(<bang>0)

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

" File-type settings {{{
" ==================

let g:python_highlight_all = 1
let g:pyindent_open_paren = '&sw'
let g:tex_flavor = 'latex'
let g:tex_conceal = 'abdmg'

augroup file_types
    autocmd!
    autocmd BufEnter /private/tmp/crontab.* setl bkc=yes
    autocmd BufEnter term://* startinsert
    autocmd BufRead,BufNewFile *.pyi setl ft=python
    autocmd BufRead,BufNewFile *.pyx setl ft=cython
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

" }}}
