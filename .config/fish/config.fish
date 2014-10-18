if test -e $HOME/.config/fish/config_local.fish
    source $HOME/.config/fish/config_local.fish
end

source $HOME/.config/fish/color_scheme.fish

set -x PATH $HOME/local/bin $PATH
set -x PATH $HOME/bin $PATH

set -g fish_key_bindings my_fish_vi_key_bindings

set -x REMOTE (last -n 1 -a ^/dev/null | head -1 | awk '{print $NF}')

