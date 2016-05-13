set background=dark
set clipboard=unnamed
set diffopt+=iwhite
set exrc
set secure
set gdefault
set hidden
set ignorecase
set modelines=10
set noerrorbells
set nofoldenable
set noshowmode
set pastetoggle=<F10>
set scrolloff=1
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
set titleold=
set undodir=$HOME/.local/share/nvim/undo
set undofile
set visualbell
set wrap
set linebreak
set nolist

let g:loaded_python_provider = 1
let g:python3_host_skip_check = 1
let python_highlight_all = 1
let g:pyindent_open_paren = '&sw'
let g:tex_flavor = "latex"

augroup restore_cursor
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe ":normal! g`\"" | endif
augroup END

"""
""" bindings
"""

let mapleader = ' '
let maplocalleader = ' '

""" vanilla neovim
nnoremap S :w<CR>
nnoremap ZA :xa<CR>
nnoremap <Leader>1 :belowright 15split<CR>:terminal<CR>
nnoremap <Leader>n :nohlsearch<CR>
nnoremap <Leader>` :cclose<CR>:lclose<CR>
nnoremap <Leader>, <F10>
nnoremap <Leader>[ :bprevious<CR>
nnoremap <Leader>] :bnext<CR>
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
if has('nvim')
    tnoremap <C-x> <C-\><C-n>
    tnoremap <C-H> <C-\><C-n><C-W>h
    tnoremap <C-J> <C-\><C-n><C-W>j
    tnoremap <C-K> <C-\><C-n><C-W>k
    tnoremap <C-L> <C-\><C-n><C-W>l
endif

""" plugin-related
nnoremap ZW :Bdelete<CR>
nnoremap <Leader>mk :Neomake!<CR>
nnoremap <Leader>T :NeomakeSh ctags -R<CR>
xmap ga <Plug>(EasyAlign)
nnoremap \\ :FZFLinesBuffer<Space>
nnoremap \ :FZFLinesAll<Space>
vnoremap \\ y:FZFLinesBuffer<Space><C-R><C-R>"<CR>
vnoremap \ y:FZFLinesAll<Space><C-R><C-R>"<CR>
nnoremap <Leader>p :FZF<CR>
nnoremap <Space>f :FZFLinesBuffer<CR>
nnoremap <Space>gf :FZFLinesAll<CR>
nnoremap <Leader>t :FZFTagsBuffer<CR>
nnoremap <Leader>gt :FZFTags<CR>
nnoremap <Leader>s :OverCommandLine<CR>%s/
vnoremap <Leader>s :OverCommandLine<CR>s/
vnoremap <Leader>ldf :Linediff<CR>
nnoremap <Leader>ldf :LinediffReset<CR>
nnoremap <Leader>go :Goyo<CR>

"""
""" session management
"""

function! FindProjectName()
    return substitute(getcwd(), '/', '%', 'g')
endfunction

function! RestoreSession(name)
    if exists("g:my_vim_from_stdin") | return | endif
    if filereadable($HOME . "/.local/share/nvim/sessions/" . a:name)
        execute 'source ~/.local/share/nvim/sessions/' . fnameescape(a:name)
    endif
endfunction

function! SaveSession(name)
    if exists("g:my_vim_from_stdin") | return | endif
    execute 'mksession! ~/.local/share/nvim/sessions/' . fnameescape(a:name)
endfunction

if argc() == 0 && v:version >= 704
    augroup session_handler
        autocmd!
        autocmd StdinReadPre * let g:my_vim_from_stdin = 1
        autocmd VimLeave * call SaveSession(FindProjectName())
        autocmd VimEnter * nested call RestoreSession(FindProjectName())
    augroup END
end

let g:test = FindProjectName()

"""
""" plugins
"""

" download vim-plug automatically if missing
if !filereadable($HOME . "/.config/nvim/autoload/plug.vim")
    call system("curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs "
                \ . "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
endif

filetype off

call plug#begin('~/.local/share/nvim/plugged')

""" colors
Plug 'chriskempson/base16-vim' " base16 for gvim
""" general plugins
" :'<,'>sort /^[^\/]*\/\(vim-\)\=/
Plug 'Konfekt/FastFold'                " more sensible fdm=syntax
Plug 'moll/vim-bbye'                   " layout stays as is on buffer close
Plug 'Raimondi/delimitMate'            " automatic closing of paired delimiters
Plug 'junegunn/vim-easy-align'         " tables in vim
Plug 'terryma/vim-expand-region'       " expand selection key: +/_
Plug 'junegunn/fzf'                    " key: <Leader>p/t/gt/f/gf
Plug 'airblade/vim-gitgutter'          " git changes
Plug 'junegunn/goyo.vim'               " distraction-free vim, key: <Leader>go
Plug 'itchyny/lightline.vim'           " fast status line
Plug 'AndrewRadev/linediff.vim'        " diffing ranges, key: <Leader>ldf
Plug 'terryma/vim-multiple-cursors'    " key: <C-N> <C-X> <C-P>
Plug 'neomake/neomake'                 " async make/linters
Plug 'osyo-manga/vim-over'             " better substitute, key: <Leader>s
Plug 'reedes/vim-pencil'               " vim for prose
Plug 'tpope/vim-repeat'                " makes . accessible to plugins
Plug 'tpope/vim-surround'              " key: cs, ds, ys
Plug 'tomtom/tcomment_vim'             " automatic comments, key: gc
Plug 'bronson/vim-trailing-whitespace' " trailing whitespace
Plug 'Shougo/vimproc', {'do': 'make'}  " makes some plugins faster
""" filetype-specific
Plug 'dag/vim-fish'
" Plug 'zchee/deoplete-jedi'
Plug 'lervag/vimtex'
Plug 'hynek/vim-python-pep8-indent'    " PEP8 indentation
Plug 'hdima/python-syntax'             " better highlighting
if v:version >= 704
    Plug 'Shougo/deoplete.nvim'            " async autocompletion
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'bling/vim-bufferline'            " open buffers in command line
endif

" Plug 'JuliaLang/julia-vim'
" Plug 'jcfaria/Vim-R-plugin'
" Plug 'keith/swift.vim'
" Plug 'linkinpark342/xonsh-vim'
" Plug 'othree/html5.vim'
" Plug 'pangloss/vim-javascript'

call plug#end()

colorscheme base16-default

filetype plugin indent on

""" filetype autocommands
augroup file_formats
    autocmd!
    autocmd FileType fortran setl cc=80,133 tw=80 com=:!>,:! fo=croq nu
    autocmd FileType python setl nosi cc=80 tw=80 fo=croq nu cino+="(0"
    autocmd FileType javascript setl cc=80 nu
    autocmd FileType cpp setl cc=80 tw=80 fo=croqw  cinoc+="(0"
    autocmd FileType markdown setl tw=80 spell ci pi sts=0 sw=4 ts=4
    autocmd FileType tex setl tw=80 ts=2 sw=2 sts=2 spell
    autocmd FileType yaml setl ts=2 sw=2 sts=2
    autocmd BufRead,BufNewFile *.pyx setl ft=cython
    autocmd BufEnter /private/tmp/crontab.* setl bkc=yes
    autocmd BufEnter term://* startinsert
augroup END

"""
""" plugin configuration
"""

let g:lightline = {
            \     'colorscheme': 'jellybeans',
            \     'component': {
            \       'lineinfo': ' %3l:%-2v',
            \     },
            \     'component_function': {
            \       'readonly': 'LightLineReadonly',
            \     },
            \     'separator': { 'left': '', 'right': '' },
            \     'subseparator': { 'left': '', 'right': '' }
            \ }

function! LightLineReadonly()
    return &readonly ? '' : ''
endfunction

let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.tex = ['.*\{', '\\cite\{.*,']
if exists("*deoplete#custom#set")
    call deoplete#custom#set('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])
endif
if !exists('g:deoplete#omni_patterns')
    let g:deoplete#omni_patterns = {}
endif

let g:pencil#wrapModeDefault = 'soft'
let g:pencil#conceallevel = 0
augroup pencil
    autocmd!
    autocmd FileType markdown call pencil#init()
    autocmd FileType tex call pencil#init()
    autocmd FileType rst call pencil#init()
augroup END

let g:multi_cursor_exit_from_insert_mode = 0

autocmd! BufWritePost * Neomake
let g:neomake_fortran_enabled_makers = ['gnu']
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_args = ['--ignore=E501,E226,E402']
let g:neomake_tex_enabled_makers = ['chktex']
let g:neomake_tex_chktex_args = ['--nowarn', '29', '--nowarn', '3']
let g:neomake_open_list = 1

let s:gfortran_maker = {
            \     'exe': 'mpifort',
            \     'args': ['-fsyntax-only', '-fcoarray=single', '-fcheck=all', '-fall-intrinsics'],
            \     'errorformat': '%-C %#,' . '%-C  %#%.%#,' . '%A%f:%l%[.:]%c:,'
            \           . '%Z%\m%\%%(Fatal %\)%\?%trror: %m,' . '%Z%tarning: %m,'
            \           . '%-G%.%#'
            \ }
let s:gfortran_pedant_maker = deepcopy(s:gfortran_maker)
call extend(s:gfortran_pedant_maker.args, [
            \     '-Wall', '-pedantic', '-Waliasing', '-Wcharacter-truncation',
            \     '-Wextra', '-Wimplicit-procedure', '-Wintrinsics-std', '-Wsurprising'
            \ ])
let g:neomake_fortran_gnu_maker = deepcopy(s:gfortran_maker)
call extend(g:neomake_fortran_gnu_maker.args, ['-std=gnu', '-ffree-line-length-none'])
let g:neomake_fortran_f95_maker = deepcopy(s:gfortran_pedant_maker)
call extend(g:neomake_fortran_f95_maker.args, ['-std=f95'])
let g:neomake_fortran_f03_maker = deepcopy(s:gfortran_pedant_maker)
call extend(g:neomake_fortran_f03_maker.args, ['-std=f2003'])
let g:neomake_fortran_f08_maker = deepcopy(s:gfortran_pedant_maker)
call extend(g:neomake_fortran_f08_maker.args, ['-std=f2008'])

let g:goyo_width = 81
let g:goyo_height = '100%'

function! s:goyo_enter()
    set noshowmode
    set noshowcmd
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    set background=dark
    syntax off
    syntax on
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

let g:bufferline_modified = '❌ '
let g:bufferline_active_buffer_left = '📝 '
let g:bufferline_active_buffer_right = ''
let g:bufferline_rotate = 1

let g:vimtex_complete_close_braces = 1
let g:vimtex_toc_enabled = 0
let g:vimtex_latexmk_enabled = 0
let g:vimtex_view_enabled = 0
let g:vimtex_motion_enabled = 0
let g:deoplete#omni_patterns.tex = '\v\\%('
            \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
            \ . '|hyperref\s*\[[^]]*'
            \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|%(include%(only)?|input)\s*\{[^}]*'
            \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . ')\m'
let g:vimtex_quickfix_ignored_warnings = [
            \     'Underfull', 'Overfull', 'specifier changed to',
            \     "'babel/polyglossia' detected",
            \     'Token not allowed in a PDF string',
            \     'unicode-math warning',
            \     'Marginpar',
            \     'Package hyperref Warning: Rerun to get /PageLabels entry.',
            \     'biblatex Warning: The following entry could not be found',
            \     "WARN - I didn't find a database entry",
            \     'Suppressing link with empty target',
            \ ]

let g:pandoc#completion#bib#mode = 'citeproc'
let g:pandoc#biblio#sources = 'b'
let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#syntax#codeblocks#embeds#langs = ['python']
let g:pandoc#modules#enabled = ['bibliographies', 'completion']
let g:deoplete#omni_patterns.pandoc= '\[@'

"""
""" FZF support
"""

command! -nargs=? FZFLinesAll call fzf#run({
            \     'source': printf('ag --nogroup --column --color "%s"',
            \           escape(empty('<args>') ? '^(?=.)' : '<args>', '"\-')),
            \     'sink*': function('s:line_handler'),
            \     'options': '--multi --ansi --delimiter :  --tac --prompt "Ag>" '
            \           . '--bind ctrl-a:select-all,ctrl-d:deselect-all -n 1,4.. --color'
            \ })

function! s:ag_to_qf(line)
    let parts = split(a:line, ':')
    return {
                \     'filename': &acd ? fnamemodify(parts[0], ':p') : parts[0],
                \     'lnum': parts[1],
                \     'col': parts[2],
                \     'text': join(parts[3:], ':')
                \ }
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
            \     'source': printf('ag --nogroup --column --color "%s" %s',
            \                      escape(empty('<args>') ? '^(?=.)' : '<args>', '"\-'),
            \                      bufname("")),
            \     'sink*': function('s:buff_line_handler'),
            \     'options': '--multi --ansi --delimiter :  --tac --prompt "Ag>" '
            \           . '--bind ctrl-a:select-all,ctrl-d:deselect-all -n 1,3.. --color'
            \ })

function! s:buff_ag_to_qf(line)
    let parts = split(a:line, ':')
    return {
                \     'filename': bufname(""),
                \     'lnum': parts[0], 'col': parts[1], 'text': join(parts[2:], ':')
                \ }
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

command! -bar FZFTags if !empty(tagfiles()) | call fzf#run({
            \     'source': 'gsed ''/^\!/ d; s/'
            \               . '^\([^\t]*\)\t\([^\t]*\)\t\(.*;"\)\t\(\w\)\t\?\([^\t]*\)\?/'
            \               . '\4\t|..|\1\t|..|\2\t|..|\5/'
            \               . '; /^l/ d'' '
            \               . join(tagfiles())
            \               . ' | column -t -s $''\t'' | gsed ''s/|..|/\t/g''',
            \     'options': '-d "\t" -n 2',
            \     'sink': function('s:tags_sink'),
            \ }) | else | call Neomake#Sh('ctags -R') | FZFTags | endif

function! s:tags_sink(line)
    execute "edit" split(a:line, "\t")[2]
    execute join(split(a:line, "\t")[4:], "\t")
endfunction

command! FZFTagsBuffer call fzf#run({
            \     'source': printf('ctags -f - --sort=no --excmd=number --language-force=%s %s',
            \                      &filetype, expand('%:S'))
            \               . ' | gsed ''/^\!/ d; s/'
            \               . '^\([^\t]*\)\t\([^\t]*\)\t\(.*;"\)\t\(\w\)\t\?\([^\t]*\)\?/'
            \               . '\4\t|..|\1/; /^l/ d'''
            \               . ' | column -t -s $''\t'' | gsed ''s/|..|/\t/g''',
            \     'sink': function('s:buffer_tags_sink'),
            \     'options': '-d "\t" -n 2 --tiebreak=index --tac',
            \     'left': '40'
            \ })

function! s:buffer_tags_sink(line)
    execute join(split(a:line, "\t")[4:], "\t")
endfunction
