if set -q fish_fzf_path
    source $fish_fzf_path/shell/key-bindings.fish
end

if [ -f ~/.config/fish/local.config.fish ]
    source ~/.config/fish/local.config.fish
end
