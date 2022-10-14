set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "jhrmnn"

hi ColorColumn ctermbg=236
hi LineNr ctermfg=238
hi SignColumn ctermbg=236
hi VertSplit ctermfg=0 ctermbg=15

hi Special ctermfg=1
hi Todo ctermbg=1
hi String ctermfg=2
hi Type ctermfg=3
hi Function ctermfg=4 cterm=italic,bold
hi Statement ctermfg=5 cterm=bold
hi PreProc ctermfg=6
hi Constant ctermfg=215
hi Identifier ctermfg=131 cterm=bold

hi Comment ctermfg=241 cterm=italic
" hi Visual ctermbg=12

hi NormalFloat ctermbg=235

hi SpellBad cterm=undercurl ctermbg=None guisp=salmon
hi SpellLocal cterm=undercurl ctermbg=None guisp=lightblue
hi SpellCap cterm=undercurl ctermbg=None guisp=lightgreen
" hi clear SpellRare

hi DiffAdd ctermbg=22
hi DiffChange ctermbg=17 cterm=None
hi DiffDelete ctermbg=52
hi DiffText ctermbg=21 cterm=None

hi SignifySignAdd ctermfg=2 ctermbg=236
hi SignifySignChange ctermfg=4 ctermbg=236
hi SignifySignDelete ctermfg=1 ctermbg=236
"
" hi Folded ctermfg=13 ctermbg=None cterm=standout
"
hi pythonException ctermfg=1
hi pythonOperator ctermfg=15 cterm=bold
hi pythonDot ctermfg=15 cterm=bold
hi pythonStrFormat ctermfg=3
hi pythonBuiltinFunc ctermfg=4 cterm=bold

hi fortranIntrinsic ctermfg=4 cterm=bold

hi cPreProc ctermfg=6 cterm=italic
hi cPreCondit ctermfg=6 cterm=italic
hi cInclude ctermfg=6 cterm=italic
