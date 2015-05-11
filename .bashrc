if [[ $BASHRC_SOURCED ]]; then exit; fi
export BASHRC_SOURCED=1

[[ -s ~/.bashrc.local ]] && . ~/.bashrc.local

export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$HOME/local/lib64:$LD_LIBRARY_PATH
export PYTHONPATH=$HOME/local/lib:$PYTHONPATH
