if [ -z "$PROFILE_SOURCED" ]; then
    [ -s ~/.bash_profile ] && source ~/.bash_profile
    return
fi

[ -s ~/.bashrc.local ] && source ~/.bashrc.local

set -o vi
shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist
shopt -s histverify
HISTFILE=~/.local/share/bash/history
HISTFILESIZE="1000000"
HISTSIZE="1000000"
HISTCONTROL="ignoreboth"
HISTIGNORE="ls:bg:fg:history"
HISTTIMEFORMAT="%F %T "

alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -l"
alias la="ls -la"
alias lt="ls -lrt"
alias lta="ls -lrta"
alias pty="ptpython"
alias ipty="ptipython"
alias jupy="jupyter notebook"
alias xo="xonsh"
alias gitk="gitk --all"
alias makeup="make -C .."
alias del="trash"
alias grep="grep --color=auto"
alias vi="vim"
if ls --color=none &>/dev/null; then
    alias ls="ls -h --color"
else
    alias ls="ls -hG"
fi

[ -s ~/.fzf.bash ] && source ~/.fzf.bash

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
