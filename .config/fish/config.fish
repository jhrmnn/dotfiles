if status --is-login
    set -x SHELL fish
end

if [ -f ~/.config/fish/local.config.fish ]
    source ~/.config/fish/local.config.fish
end
