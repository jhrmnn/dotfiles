packadd vimtex
packadd tex-conceal.vim

let g:vimtex_compiler_enabled = 0

call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete,
            \ })
