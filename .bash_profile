[[ -s ~/.bashrc ]] && . ~/.bashrc
[[ -s ~/.bash_profile.local ]] && . ~/.bash_profile.local

alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls -ltr"
alias py="ptpython --vi"
alias ipy="ptipython --vi"
alias sp="tmux split"
alias vsp="tmux split -h"
alias kp="tmux kill-pane"
alias make..="make -C .."
alias xargs="xargs -o"
alias gitk="gitk --all"

set -o vi
shopt -s histappend
shopt -s cmdhist
shopt -s histverify
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE=ls:bg:fg:history
export HISTTIMEFORMAT="%F %T "

if ls --color=none &>/dev/null
then
    export GREP_OPTIONS="--color=auto"
    alias ls="ls -h"
else
    alias ls="ls -hG"
fi

insertinreadline() {
    READLINE_LINE=${READLINE_LINE:0:$READLINE_POINT}$1${READLINE_LINE:$READLINE_POINT}
    READLINE_POINT=`expr $READLINE_POINT + ${#1}`
}

if which fzf &>/dev/null
then
    bind -x '"\C-t": insertinreadline "`locate . | fzf`"'
    bind -x '"\C-r": insertinreadline \
        "`HISTTIMEFORMAT= history | \
        fzf --tac --no-sort -n 2.. --tiebreak=index --toggle-sort=ctrl-r | \
        sed \"s/^ *[0-9]* *//\"`"'
    export FZF_COMPLETION_TRIGGER='§§'
    export FZF_DEFAULT_OPTS="-x --bind=ctrl-u:page-up,ctrl-d:page-down"
    which ag &>/dev/null && export FZF_DEFAULT_COMMAND='ag -l -g ""'
fi

vim () {
    if [[ $# == 1 && -d $1 ]]; then
        (cd $1 && command vim --servername VIM)
    else
        command vim --servername VIM "$@"
    fi
}

Color_Off='\[\e[0m\]'
Black='\[\e[0;30m\]'
Red='\[\e[0;31m\]'
Green='\[\e[0;32m\]'
Yellow='\[\e[0;33m\]'
Blue='\[\e[0;34m\]'
Magenta='\[\e[0;35m\]'
Cyan='\[\e[0;36m\]'
White='\[\e[0;37m\]'

PROMPT_COMMAND="PS_STATUS=\$?; history -a; $PROMPT_COMMAND"
PS1="\
\A\
 $Cyan\$(cut -c1-3 <<<\u)$Blue@$Cyan\$(cut -c1-5 <<<\h)\
 $Yellow\$(awk -F '/' '{ORS=\"\";\
                        for (i=1; i<NF; i++) print substr(\$i, 1, 1) \"/\";\
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
 $Blue\$(if [[ \j > 0 ]]; then echo '\j '; fi)\
$Red\$(if [[ \$PS_STATUS != 0 ]]; then echo \"[\$PS_STATUS]\"; fi)\
$Black\$\
 $Color_Off\
"

# https://gist.github.com/junegunn/f4fca918e937e6bf5bad
fshow() {
    local out shas sha q k
    while out=$(
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --multi --no-sort --reverse --query="$q" \
            --print-query --expect=ctrl-k --toggle-sort=\`); do
        q=$(head -1 <<< "$out")
        k=$(head -2 <<< "$out" | tail -1)
        shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
        [ -z "$shas" ] && continue
        if [ "$k" = ctrl-k ]; then
            git diff --color=always $shas | less -R
        else
            for sha in $shas; do
                git show --color=always $sha | less -R
            done
        fi
    done
}
