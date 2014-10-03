if [[ -e ~/.bash_aliases ]]; then
	. ~/.bash_aliases
fi

if [[ -e ~/bin ]]; then
	export PATH=~/bin:$PATH
fi

export GREP_OPTIONS='--color=auto'

set -o vi 

export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w \$ \[\033[00m\]'

### bash history behaviour ###
shopt -s histappend
shopt -s cmdhist
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTCONTROL=ignoreboth
export HISTIGNORE='ls:bg:fg:history'
export HISTTIMEFORMAT='%F %T '
export PROMPT_COMMAND='history -a ; echo -ne "\033]0;${PWD}\007" ; $PROMPT_COMMAND'

### needed by FHI-aims
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export MKL_DYNAMIC=FALSE
ulimit -s unlimited

NWCHEM_TOP=/mnt/lxfs2/scratch/jhermann/software/nwchem-6.0
export PATH=$PATH:$NWCHEM_TOP/bin/LINUX64
export PATH=$HOME/software/anaconda/bin:$PATH
export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/software/anaconda/lib

export PYTHONPATH=$HOME/local/lib

export REMOTE=`last -n 1 -a | head -1 | awk '{print $NF}'`
