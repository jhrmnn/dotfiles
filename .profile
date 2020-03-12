if [ -n "$PROFILE_SOURCED" ]; then
    return
fi
export PROFILE_SOURCED=1

OS_NAME=$(uname -s)

export CLICOLOR=1

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export XDG_CONFIG_HOME="$HOME/.config"
if [ "$OS_NAME" = "Darwin" ]; then
    export XDG_CACHE_HOME="$HOME/Library/Caches"
    export XDG_DATA_HOME="$HOME/Library/Application Support"
else
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if command -v nvim >/dev/null; then
    export EDITOR=nvim
fi

export FZF_DEFAULT_COMMAND='rg -l ""'
export FZF_DEFAULT_OPTS="--bind=ctrl-u:page-up,ctrl-d:page-down --reverse"

if [ "$OS_NAME" = "Darwin" ]; then
    export HOMEBREW_PREFIX="/usr/local"
elif [ -e $HOME/.linuxbrew ]; then
    export HOMEBREW_PREFIX=$(realpath $HOME/.linuxbrew)
fi
if [ -n "$HOMEBREW_PREFIX" ]; then
    export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar";
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew";
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin${PATH+:$PATH}";
    export MANPATH="$HOMEBREW_PREFIX/share/man${MANPATH+:$MANPATH}:";
    export INFOPATH="$HOMEBREW_PREFIX/share/info${INFOPATH+:$INFOPATH}";
fi

if [ -r ~/.profile.local ]; then
    . ~/.profile.local
fi

export PATH="$HOME/bin:$PATH"

if [ "$OS_NAME" = "Darwin" ]; then
    export PATH="$PATH:/opt/bin"
    export PATH="$PATH:$HOME/Library/Ruby/bin"

    export TERMINFO_DIRS="/usr/share/terminfo"
    export N_PREFIX="/opt"
    export GEM_HOME="$HOME/Library/Ruby"
fi

export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export WORKON_HOME="$XDG_CACHE_HOME/virtualenvs"
export KR_SKIP_SSH_CONFIG=1
export GPG_TTY=$(tty)

export CONDA_ENVS_PATH="$XDG_CACHE_HOME/conda/envs"
export CONDA_PKGS_DIRS="$XDG_CACHE_HOME/conda/pkgs"
export CONDA_BLD_PATH="$XDG_CACHE_HOME/conda/conda-bld"

# my variables

export BUILD_HOME="$XDG_CACHE_HOME/Builds"
export _MY_PATH=$PATH

if [ "$OS_NAME" = "Darwin" ]; then
    export OPT_PREFIX=/opt
else
    export OPT_PREFIX=$HOME/opt
fi
