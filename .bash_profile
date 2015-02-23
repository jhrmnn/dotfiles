[[ -s ~/.bashrc && -z $BASHRC_SOURCED ]] && . ~/.bashrc
[[ -s ~/.bash_profile.local ]] && . ~/.bash_profile.local

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
    '
PS1="\
\A\
 $Cyan\$(cut -c1-3 <<<\u)$Blue@$Cyan\$(cut -c1-5 <<<\h)\
 $Yellow\$(awk -F '/' '{ORS=\"\";\
                        for (i=1; i<NF; i++) print substr(\$i, 1, 1) \"/\";\
                        print \$NF}' \
           <<<'\w')\
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
shopt -s histverify
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE=ls:bg:fg:history
export HISTTIMEFORMAT="%F %T"

export GREP_OPTIONS="--color=auto"
if ls --color=none &>/dev/null; then
    alias ls="ls -h --color=auto"
else
    alias ls="ls -hG"
fi

[[ -s ~/.bash_aliases ]] && . ~/.bash_aliases
