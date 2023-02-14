[ -s ~/.bashrc.local ] && source ~/.bashrc.local

if command -v nvim >/dev/null; then
    export EDITOR=nvim
fi
export CLICOLOR=1
export FZF_DEFAULT_COMMAND='rg -l ""'
export FZF_DEFAULT_OPTS="--bind=ctrl-u:page-up,ctrl-d:page-down,alt-j:down,alt-k:up --reverse"
export FZF_TMUX_OPTS="-p"
export YDIFF_OPTIONS="-s -w0 --wrap"

set -o vi
shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist
shopt -s histverify
[ -w "$XDG_DATA_HOME/bash/history" ] && HISTFILE="$XDG_DATA_HOME/bash/history"
HISTFILESIZE="1000000"
HISTSIZE="1000000"
HISTCONTROL="ignoreboth"
HISTIGNORE="ls:bg:fg:history"
HISTTIMEFORMAT="%F %T "

alias ..="cd .."
alias ...="cd ../.."
if command -v exa >/dev/null; then
    alias ls="exa"
    alias ll="exa -l"
    alias la="exa -la"
    alias ltr="exa -lT"
    alias lt="exa -ls modified"
    alias lta="exa -las modified"
    alias lzf="exa -lT --color=always \| fzf --ansi"
    alias lss="exa -lT --color=always \| less -R"
else
    alias ll="ls -l"
    alias la="ls -la"
    alias lt="ls -lrt"
    alias lta="ls -lrta"
fi
alias pty="ptpython"
alias ipty="ptipython"
alias jupy="jupyter notebook"
alias xo="xonsh"
alias gitk="gitk --all"
alias makeup="make -C .."
alias del="trash"
alias grep="grep --color=auto"
alias vi="vim"
alias lg="lazygit"
if ls --color=none &>/dev/null; then
    alias ls="ls -h --color"
else
    alias ls="ls -hG"
fi

if command -v nvim >/dev/null; then
    alias vim="nvim"
fi

Color_Off='\[\e[0m\]'
Black='\[\e[30m\]'
Red='\[\e[31m\]'
BrRed='\[\e[91m\]'
BoldRed='\[\e[1;31m\]'
Green='\[\e[32m\]'
BoldGreen='\[\e[1;32m\]'
Yellow='\[\e[33m\]'
BoldYellow='\[\e[1;33m\]'
Blue='\[\e[34m\]'
BoldBlue='\[\e[1;34m\]'
Magenta='\[\e[35m\]'
Cyan='\[\e[36m\]'
BrCyan='\[\e[96m\]'
BoldCyan='\[\e[1;36m\]'
White='\[\e[37m\]'
if [[ -n "$SSH_CLIENT" || -n "$SSH_CLIENT2" ]]; then
    userhost=" $BrRed\u$BrCyan@$BrRed\h"
else
    userhost=""
fi
PROMPT_COMMAND="PS_STATUS=\$?; history -a; $PROMPT_COMMAND"
PS1="\
\A$userhost\
 $BoldCyan\$(awk -F '/' '{ORS=\"\";\
                      for (i=1; i<NF; i++) print substr(\$i, 1, 2) \"/\";\
                      print \$NF}' <<<'\w')\
\$(if git rev-parse --is-inside-work-tree &>/dev/null; then\
    echo -n ' ';\
    if git status --porcelain | egrep . &>/dev/null; then echo -n '$BoldYellow';\
    else echo -n '$BoldGreen'; fi;\
    echo -n '('\$(git rev-parse --abbrev-ref HEAD 2>/dev/null)')';\
fi)\
$BoldBlue\$(if [[ \j > 0 ]]; then echo ' \j'; fi)\
$BoldRed\$(if [[ \$PS_STATUS != 0 ]]; then echo \" [\$PS_STATUS]\"; fi)\
 $Color_Off\
"
