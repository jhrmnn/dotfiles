if [ -n "$PROFILE_SOURCED" ]; then
    return
fi
export PROFILE_SOURCED=1

export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

export FZF_DEFAULT_COMMAND='rg -l ""'
export FZF_DEFAULT_OPTS="--bind=ctrl-u:page-up,ctrl-d:page-down --reverse"

if [ -r ~/.profile.local ]; then
    . ~/.profile.local
fi

export PATH="$HOME/bin:$PATH"

export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSHISTFILE="$XDG_DATA_HOME/lesshst"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export WORKON_HOME="$XDG_CACHE_HOME/virtualenvs"

export CONDA_ENVS_PATH="$XDG_CACHE_HOME/conda/envs"
export CONDA_PKGS_DIRS="$XDG_CACHE_HOME/conda/pkgs"
export CONDA_BLD_PATH="$XDG_CACHE_HOME/conda/conda-bld"

export _MY_PATH=$PATH

export KR_SKIP_SSH_CONFIG=1

export GPG_TTY=$(tty)
