if status --is-login
    set -x SHELL (which fish)
end

if command -v nvim >/dev/null
    alias vim 'nvim'
    alias vimdiff 'nvim -d'
end

if command -v direnv >/dev/null
    direnv hook fish | source
end

if [ -f ~/.config/fish/local.config.fish ]
    source ~/.config/fish/local.config.fish
end
