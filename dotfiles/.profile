if [ -n "$PROFILE_SOURCED" ]; then
    return
fi
export PROFILE_SOURCED=1

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH=~/local/bin:"$PATH"
export PATH=~/bin:"$PATH"

export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

export GNUPGHOME=~/.config/gnupg
export JUPYTER_CONFIG_DIR=~/.config/jupyter
export LESSHISTFILE=~/.cache/lesshst
export TERMINFO_DIRS=~/.local/share/terminfo:/usr/share/terminfo
export INPUTRC=~/.config/readline/inputrc

if [ -r ~/.profile.local ]; then
    source ~/.profile.local;
fi
