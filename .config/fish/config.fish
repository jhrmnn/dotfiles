if test -e $HOME/.config/fish/local.config.fish
    source $HOME/.config/fish/local.config.fish
end

source $HOME/.config/fish/color_scheme.fish

set -x PATH $HOME/local/bin $PATH
set -x PATH $HOME/bin $PATH

set -x PYTHONPATH $HOME/local/lib $PYTHONPATH
set -x PYTHONPATH $HOME/bin $PYTHONPATH

set -g fish_key_bindings my_fish_vi_key_bindings

set -x REMOTE (last -n 1 -a ^/dev/null | head -1 | awk '{print $NF}')

