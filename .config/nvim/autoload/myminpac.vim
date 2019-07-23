" vim: set foldmethod=marker foldlevel=0:

packadd minpac

call minpac#init({'dir': $XDG_DATA_HOME . '/nvim/site'})

call minpac#add('k-takata/minpac', {'type': 'opt'})

" Color schemes {{{
" -------------
call minpac#add('chriskempson/base16-vim', {'type': 'opt'})
" }}}

" Vanilla Vim enhancements {{{
" ------------------------
call minpac#add('moll/vim-bbye')                    " make layout stay as is on buffer close
call minpac#add('rickhowe/diffchar.vim')            " bring word diff to vim
call minpac#add('tpope/vim-repeat')                 " make . accessible to plugins
" }}}

" New functionality {{{
" -----------------
call minpac#add('AndrewRadev/linediff.vim', {'type': 'opt'})         " diffing ranges, key: <Leader>ldf
call minpac#add('bronson/vim-trailing-whitespace')  " highlight trailing whitespace
call minpac#add('itchyny/lightline.vim')            " fast status line
call minpac#add('junegunn/fzf.vim')                 " useful commands using FZF
call minpac#add('junegunn/goyo.vim', {'type': 'opt'})  " distraction-free vim, key: <Leader>go
call minpac#add('junegunn/limelight.vim', {'type': 'opt'})  " dim surrounding paragrpahs
call minpac#add('junegunn/vim-easy-align', {'type': 'opt'})  " easy table alignment
call minpac#add('justinmk/vim-sneak', {'type': 'opt'})  " additional movements
call minpac#add('ludovicchabant/vim-gutentags')     " ctags management
call minpac#add('luochen1990/rainbow')              " colored parentheses
call minpac#add('mhinz/vim-signify')                " git changes
call minpac#add('mbbill/undotree')
call minpac#add('michaeljsmith/vim-indent-object')  " indentation-based targets
call minpac#add('neomake/neomake', {'type': 'opt'}) " async make
call minpac#add('raimondi/delimitmate')
call minpac#add('reedes/vim-pencil')                " handle single-line paragraphs
call minpac#add('terryma/vim-expand-region')        " expand selection key: +/_
call minpac#add('terryma/vim-multiple-cursors')     " key: <C-N> <C-X> <C-P>
call minpac#add('tommcdo/vim-exchange')             " exchange motion: cx
call minpac#add('tomtom/tcomment_vim')              " automatic comments, key: gc
call minpac#add('lambdalisue/gina.vim')
call minpac#add('tpope/vim-surround')               " key: cs, ds, ys
call minpac#add('w0rp/ale')                         " linters
call minpac#add('wellle/targets.vim')               " extra motion targets
call minpac#add('bling/vim-bufferline')             " show open buffers in command line
call minpac#add('Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'})
call minpac#add('roxma/nvim-yarp', {'type': 'opt'})
call minpac#add('roxma/vim-hug-neovim-rpc', {'type': 'opt'})
" }}}

" File-type plugins {{{
" -----------------
call minpac#add('sheerun/vim-polyglot')
call minpac#add('chikamichi/mediawiki.vim', {'type': 'opt'})
call minpac#add('chrisbra/csv.vim', {'type': 'opt'})
call minpac#add('igordejanovic/textx.vim', {'type': 'opt'})
call minpac#add('plasticboy/vim-markdown', {'type': 'opt'})
call minpac#add('zchee/deoplete-jedi', {'type': 'opt'})
call minpac#add('lervag/vimtex', {'type': 'opt'})
call minpac#add('KeitaNakamura/tex-conceal.vim', {'type': 'opt'})
" }}}

function myminpac#init()
endfunction
