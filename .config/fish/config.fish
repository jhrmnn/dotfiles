if status --is-login
    set -x SHELL (which fish)
end

alias vim 'nvim'
alias vimdiff 'nvim -d'

if [ -f ~/.config/fish/local.config.fish ]
    source ~/.config/fish/local.config.fish
end

direnv hook fish | source
