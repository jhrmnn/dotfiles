if [ -n "$PROFILE_SOURCED" ]; then
    return
fi
export PROFILE_SOURCED=1

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH=~/.local/bin:"$PATH"
export PATH=~/local/bin:"$PATH"
export PATH=~/bin:"$PATH"

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export JUPYTER_CONFIG_DIR=~/.config/jupyter
export LESSHISTFILE=~/.cache/lesshst
export TERMINFO_DIRS=~/.local/share/terminfo:/usr/share/terminfo
export INPUTRC=~/.config/readline/inputrc

export FZF_DEFAULT_OPTS="--bind=ctrl-u:page-up,ctrl-d:page-down --reverse"
if which ag &>/dev/null; then
    export FZF_DEFAULT_COMMAND='ag -l -g ""'
fi

if [ -r ~/.profile.local ]; then
    source ~/.profile.local;
fi
