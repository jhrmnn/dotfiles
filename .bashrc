[[ -e ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -e ~/.bashrc.local ]] && . ~/.bashrc.local

export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$HOME/local/lib64:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/local/lib:$PYTHONPATH
export PYTHONPATH=$HOME/bin:$PYTHONPATH
export FISH_PATH=`which fish`

