[[ -s ~/.bashrc ]] && . ~/.bashrc

Color_Off='\[\e[0m\]'
Black='\[\e[0;30m\]'
Red='\[\e[0;31m\]'
Green='\[\e[0;32m\]'
Yellow='\[\e[0;33m\]'
Blue='\[\e[0;34m\]'
Purple='\[\e[0;35m\]'
Cyan='\[\e[0;36m\]'
White='\[\e[0;37m\]'

PROMPT_COMMAND='\
    PS_STATUS=$?;\
    history -a;\
    history -n;\
    '
PS1="\
\A\
 $Cyan\$(cut -c1-3 <<<\u)$Blue@$Cyan\$(cut -c1-5 <<<\h)\
 $Yellow\$(sed -E 's|/(.)[^/]*/|/\1/|g' <<<'\w')\
\$(if git status &>/dev/null; then\
    echo -n ' ';\
    if git status --porcelain | egrep . &>/dev/null; then\
        echo -n '$Red';\
    else\
        echo -n '$Green';\
    fi;\
    git rev-parse --abbrev-ref HEAD;\
    fi)\
 $Blue\$(if [[ \j > 0 ]]; then echo \j; fi)\
$Red\$(if [[ \$PS_STATUS != 0 ]]; then echo \"[\$PS_STATUS]\"; fi)\
$Black\$\
 $Color_Off\
"

shopt -s histappend
shopt -s cmdhist
HISTFILESIZE=1000000
HISTCONTROL=ignoreboth
HISTIGNORE=ls:bg:fg:history
HISTTIMEFORMAT="%F %T"
export TMPDIR=/tmp

export GREP_OPTIONS="--color=auto"
alias ls="ls -hG"

[[ -e ~/.bash_aliases ]] && . ~/.bash_aliases

[[ -s ~/.rvm/scripts/rvm ]] && . ~/.rvm/scripts/rvm
