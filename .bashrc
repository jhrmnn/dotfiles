[[ $BASHRC_SOURCED ]] && return || export BASHRC_SOURCED=1
[[ -s ~/.bashrc.local ]] && . ~/.bashrc.local

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$HOME/local/lib64:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/local/lib:$PYTHONPATH
