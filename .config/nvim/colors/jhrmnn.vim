set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "jhrmnn"

hi ColorColumn ctermbg=Green
hi LineNr ctermbg=Green
hi SignColumn ctermbg=Green

hi Normal ctermfg=LightGrey
hi Statement ctermfg=DarkMagenta cterm=bold
hi Function ctermfg=DarkBlue
hi String ctermfg=DarkGreen
hi PreProc ctermfg=DarkCyan
hi Constant ctermfg=Red
hi Identifier ctermfg=7
hi Special ctermfg=DarkRed
hi Comment ctermfg=Yellow cterm=italic
hi Type ctermfg=3
hi Todo ctermbg=DarkRed

hi SpellBad cterm=undercurl ctermbg=None guisp=salmon
hi clear SpellCap
hi SpellLocal cterm=None

hi SignifySignAdd ctermfg=DarkGreen ctermbg=Green
hi SignifySignChange ctermfg=DarkBlue ctermbg=Green
hi SignifySignDelete ctermfg=DarkRed ctermbg=Green

hi Folded ctermfg=None ctermbg=None cterm=strikethrough

hi pythonRawString ctermfg=Magenta cterm=italic
hi pythonException ctermfg=DarkRed
hi pythonOperator ctermfg=White cterm=bold
hi pythonDot ctermfg=White cterm=bold
hi pythonStrFormat ctermfg=3
