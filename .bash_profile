[[ -e ~/.bashrc ]] && . ~/.bashrc

export GREP_OPTIONS='--color=auto'
export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \$ \[\033[00m\]'
shopt -s histappend
shopt -s cmdhist
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:bg:fg:history'
export HISTTIMEFORMAT='%F %T '
export PROMPT_COMMAND='history -a ; echo -ne "\033]0;${PWD}\007" ; $PROMPT_COMMAND'

export REMOTE=`last -n 1 -a 2>/dev/null | head -1 | awk '{print $NF}'`

[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
