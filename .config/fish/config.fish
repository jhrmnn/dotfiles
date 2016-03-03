for w in (abbr -l)
    abbr -e $w
end
abbr ll="ls -l"
abbr la="ls -a"
abbr lla="ls -la"
abbr lt="ls -ltr"
abbr py="python"
abbr py3="python3"
abbr pty="ptpython"
abbr ipty="ptipython"
abbr jupy="jupyter notebook"
abbr sp="tmux split"
abbr vsp="tmux split -h"
abbr kp="tmux kill-pane"
abbr gitk="gitk --all"
abbr mk="make"
abbr mku="make -C .."
abbr caf="./caf"

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

