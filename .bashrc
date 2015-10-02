shopt -q login_shell && [[ -z $BASH_PROFILE_SOURCED ]] && return
[[ -s ~/.bashrc.local ]] && . ~/.bashrc.local

set -o vi
shopt -s histappend
shopt -s cmdhist
shopt -s histverify
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE=ls:bg:fg:history
export HISTTIMEFORMAT="%F %T "

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$HOME/local/lib64:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/local/lib:$PYTHONPATH
