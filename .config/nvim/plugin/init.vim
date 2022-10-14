" vim: set foldmethod=marker foldlevel=0:

if !isdirectory($XDG_DATA_HOME . '/nvim/site/pack')
    finish
endif

nnoremap <silent> <Leader>d :Bdelete<CR>
xmap ga <Plug>(EasyAlign)
nnoremap \\ :BLines<Space>
nnoremap \ :Rg<Space>
nnoremap <silent> <Leader>h :Helptags<CR>
nnoremap <silent> <Leader>p :Files<CR>

" Rainbow {{{
" ---------
let g:rainbow_active = 1
let g:rainbow_conf = {
            \     'separately': {
            \         'cmake': 0,
            \     }
            \ }
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
		    \                  [ 'bufnum', 'filename', 'modified' ]],
		    \         'right': [[ 'lineinfo' ],
		    \                   [ 'percent' ],
		    \                   [ 'fileformat', 'fileencoding', 'filetype' ]]
            \     },
		    \    'inactive': {
		    \         'left': [[ 'bufnum', 'filename' ]],
		    \         'right': [[ 'lineinfo' ],
		    \                   [ 'percent' ]]
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
    DelimitMateOff
endfunction

function g:Multiple_cursors_after()
    DelimitMateOn
endfunction
" }}}
