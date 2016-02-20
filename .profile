export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export PATH=$HOME/local/bin:$PATH
export PATH=$HOME/bin:$PATH
export PYTHONPATH="$PYTHONPATH:$HOME/local/lib"

export GREP_OPTIONS="--color=auto"

if [ -r  ~/.profile.local ]; then source ~/.profile.local; fi
