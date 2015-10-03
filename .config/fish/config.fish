if test -e ~/.config/fish/local.config.fish
    . ~/.config/fish/local.config.fish
end

set -x PATH $HOME/local/bin $PATH
set -x PATH $HOME/bin $PATH
set -x LD_LIBRARY_PATH $HOME/local/lib:$HOME/local/lib64 $LD_LIBRARY_PATH
set -x PYTHONPATH $HOME/local/lib $PYTHONPATH

alias .. "cd .."
alias ... "cd ../.."
alias ll "ls -l"
alias la "ls -a"
alias lla "ls -la"
alias lt "ls -ltr"
alias py "ptpython"
alias ipy "ptipython"
alias sp "tmux split"
alias vsp "tmux split -h"
alias kp "tmux kill-pane"
alias gitk "gitk --all"
alias make.. "make -C .."

set -x GREP_OPTIONS "--color=auto"

if ls --color=none >/dev/null ^&1
    alias ls "ls -h --color"
else
    alias ls "ls -hG"
end

set -g fish_key_bindings fish_vi_key_bindings
