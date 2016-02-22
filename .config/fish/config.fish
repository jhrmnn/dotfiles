abbr -a ll="ls -l"
abbr -a la="ls -a"
abbr -a lla="ls -la"
abbr -a lt="ls -ltr"
abbr -a py="python"
abbr -a py3="python3"
abbr -a pty="ptpython"
abbr -a ipty="ptipython"
abbr -a sp="tmux split"
abbr -a vsp="tmux split -h"
abbr -a kp="tmux kill-pane"
abbr -a gitk="gitk --all"
abbr -a mku="make -C .."

set -x GREP_OPTIONS "--color=auto"

if ls --color=none >/dev/null ^&1
    alias ls "ls -h --color"
else
    alias ls "ls -hG"
end

set -g fish_key_bindings fish_vi_key_bindings

if test -f ~/.config/fish/local.config.fish
    . ~/.config/fish/local.config.fish
end

