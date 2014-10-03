# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
source $fish_path/oh-my-fish.fish



if test -e $HOME/.config/fish/config_local.fish
    source $HOME/.config/fish/config_local.fish
end

set -x PATH $HOME/local/bin $PATH

function my_fish_vi_key_bindings
    fish_vi_key_bindings
    bind -M insert \cc kill-whole-line force-repaint
end

set -g fish_key_bindings my_fish_vi_key_bindings

