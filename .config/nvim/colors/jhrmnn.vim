set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "jhrmnn"

hi ColorColumn ctermbg=Green
hi LineNr ctermfg=Magenta ctermbg=Green
hi SignColumn ctermbg=Green
hi VertSplit ctermfg=Black ctermbg=Black

hi Normal ctermfg=LightGrey
hi Statement ctermfg=DarkMagenta cterm=bold
hi Function ctermfg=DarkBlue cterm=italic
hi String ctermfg=DarkGreen
hi PreProc ctermfg=DarkCyan
hi Constant ctermfg=Red
hi Identifier ctermfg=7
hi Special ctermfg=DarkRed
hi Comment ctermfg=Yellow cterm=italic
hi Type ctermfg=3
hi Todo ctermbg=DarkRed
hi Visual ctermbg=12

hi SpellBad cterm=undercurl ctermbg=None guisp=salmon
hi clear SpellCap
hi clear SpellLocal
hi clear SpellRare

hi DiffAdd ctermbg=22
hi DiffChange ctermbg=26
hi DiffText ctermbg=26
hi DiffDelete ctermbg=88

hi SignifySignAdd ctermfg=DarkGreen ctermbg=Green
hi SignifySignChange ctermfg=DarkBlue ctermbg=Green
hi SignifySignDelete ctermfg=DarkRed ctermbg=Green

hi Folded ctermfg=Magenta ctermbg=None cterm=standout

hi pythonException ctermfg=DarkRed
hi pythonOperator ctermfg=White cterm=bold
hi pythonDot ctermfg=White cterm=bold
hi pythonStrFormat ctermfg=3
hi pythonBuiltinFunc cterm=bold ctermfg=DarkBlue

hi fortranIntrinsic cterm=bold ctermfg=DarkBlue

hi cPreProc ctermfg=DarkCyan cterm=italic
hi cPreCondit ctermfg=DarkCyan cterm=italic
hi cInclude ctermfg=DarkCyan cterm=italic
