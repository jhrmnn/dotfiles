" vim: set foldmethod=marker foldlevel=0:

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

" Plugin management {{{
" =================

if !has('nvim')
  packadd nvim-yarp
  packadd vim-hug-neovim-rpc
endif

" }}}

" Plugin mappings {{{
" ---------------
nnoremap <silent> <Leader>d :Bdelete<CR>
nnoremap <Leader>mk :Neomake!<CR>
xmap ga <Plug>(EasyAlign)
nnoremap <silent> <Leader>gs :Gina status<CR>
nnoremap <silent> <Leader>gc :Gina commit<CR>
nnoremap <silent> <Leader>gl :Gina plog --all<CR>
nnoremap \\ :BLines<Space>
nnoremap \ :Rg<Space>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>p :Files<CR>
nnoremap <silent> <Space>f :BLines<CR>
nnoremap <silent> <Space>F :Rg<CR>
nnoremap <silent> <Leader>t :BTags<CR>
nnoremap <silent> <Leader>T :Tags<CR>
nnoremap <silent> <Leader>gt :execute 'silent !' . g:fzf_tags_command<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
vnoremap <silent> <Leader>ldf :packadd linediff.vim \| Linediff<CR>
nnoremap <silent> <Leader>ldf :LinediffReset<CR>
nnoremap <silent> <Leader>go :packadd goyo.vim \| packadd limelight.vim \| Goyo<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gw :Gwrite \| tabclose<CR>
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
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }
" }}}

" Gutentags {{{
" ---
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0
let g:gutentags_ctags_extra_args = ['--fortran-kinds=-l']
" }}}

" Limelight {{{
" ---------
let g:limelight_conceal_ctermfg = 13
" }}}

" Rainbow {{{
" ---------
let g:rainbow_active = 1
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
    ALEDisable
    DelimitMateOff
endfunction

function g:Multiple_cursors_after()
    call deoplete#custom#buffer_option('auto_complete', v:true)
    ALEEnable
    DelimitMateOn
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
call deoplete#custom#source('_', 'matchers', ['matcher_length', 'matcher_full_fuzzy'])
autocmd InsertEnter * call deoplete#enable()
" }}}

" Goyo {{{
" ----
let g:goyo_width = 75

function! s:goyo_enter()
    set noshowcmd
    set scrolloff=10
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

" Gina {{{
" ----
call gina#custom#command#option('status', '--opener', 'split')
call gina#custom#mapping#nmap('status', 'DD', '<Plug>(gina-diff-split)')
call gina#custom#command#alias('log', 'plog')
call gina#custom#command#option('plog', '--graph')
call gina#custom#command#option('plog', '--pretty', 'format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset')
call gina#custom#command#option('plog', '--abbrev-commit')
call gina#custom#command#option('plog', '--stat')
" }}}

" Vimtex {{{
" ----
let g:vimtex_compiler_enabled = 0

call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete,
            \ })
" }}}

" }}}
