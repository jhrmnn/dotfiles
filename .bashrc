[[ -e ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -e ~/.bash_local ]] && . ~/.bash_local

export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$HOME/local/lib64:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/local/lib
export FISH_PATH=`which fish`

