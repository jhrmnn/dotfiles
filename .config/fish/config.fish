if test -e $HOME/.config/fish/config_local.fish
    source $HOME/.config/fish/config_local.fish
end

source $HOME/.config/fish/color_scheme.fish

set -x PATH $HOME/local/bin $PATH

function my_fish_vi_key_bindings
    fish_vi_key_bindings
    bind \cc kill-whole-line
    bind -M insert \cc kill-whole-line
    bind -M insert -m default \e backward-char
end

set -g fish_key_bindings my_fish_vi_key_bindings

set -x REMOTE (last -n 1 -a ^/dev/null | head -1 | awk '{print $NF}')

function py
    ptpython --vi
end
