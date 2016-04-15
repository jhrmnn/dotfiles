[[ -z "$PROFILE_SOURCED" ]] && { [[ -s ~/.bash_profile ]] && . ~/.bash_profile; return; }

set -o vi
shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist
shopt -s histverify
HISTFILESIZE="1000000"
HISTSIZE="1000000"
HISTCONTROL="ignoreboth"
HISTIGNORE="ls:bg:fg:history"
HISTTIMEFORMAT="%F %T "

alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls -ltr"
alias py="python"
alias py3="python3"
alias pty="ptpython"
alias ipty="ptipython"
alias jupy="jupyter notebook"
alias sp="tmux split"
alias vsp="tmux split -h"
alias kp="tmux kill-pane"
alias gitk="gitk --all"
alias mk="make"
alias mku="make -C .."
if ls --color=none &>/dev/null
then
    alias ls="ls -h --color"
else
    alias ls="ls -hG"
fi

[[ -s ~/.bashrc.local ]] && . ~/.bashrc.local

Color_Off='\[\e[0m\]'
Black='\[\e[0;30m\]'
Red='\[\e[0;31m\]'
Green='\[\e[0;32m\]'
Yellow='\[\e[0;33m\]'
Blue='\[\e[0;34m\]'
Magenta='\[\e[0;35m\]'
Cyan='\[\e[0;36m\]'
White='\[\e[0;37m\]'
if [[ -n "$SSH_CLIENT" || -n "$SSH_CLIENT2" ]]; then
    _name_color=$Green
    _at_color=$Red
else
    _name_color=$Cyan
    _at_color=$Blue
fi
PROMPT_COMMAND="PS_STATUS=\$?; history -a; $PROMPT_COMMAND"
PS1="\
\A\
 $_name_color\$(cut -c1-3 <<<\u)$_at_color@$_name_color\$(cut -c1-3 <<<\h)\
 $Yellow\$(awk -F '/' '{ORS=\"\";\
                        for (i=1; i<NF; i++) print substr(\$i, 1, 2) \"/\";\
                        print \$NF}' \
           <<<'\w')\
\$(if git rev-parse --is-inside-work-tree &>/dev/null; then\
    echo -n ' ';\
    if git status --porcelain | egrep . &>/dev/null; then\
        echo -n '$Red';\
    else\
        echo -n '$Green';\
    fi;\
    git rev-parse --abbrev-ref HEAD 2>/dev/null;\
    fi)\
$Blue\$(if [[ \j > 0 ]]; then echo ' \j'; fi)\
$Red\$(if [[ \$PS_STATUS != 0 ]]; then echo \" [\$PS_STATUS]\"; fi)\
 $Color_Off\
"