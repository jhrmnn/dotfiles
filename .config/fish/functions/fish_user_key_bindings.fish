if functions -q fzf_key_bindings
    fzf_key_bindings
end

function cancel_commandline
    set -l cmd (commandline)
    if [ -n $cmd ]
        commandline -C 1000000
        echo -n (set_color brgrey -o)'^C'(set_color normal)(tput el)
    end
    for i in (seq (commandline -L))
        echo ''
    end
    commandline ''
    commandline -f repaint
end

function fzf_dir_history
    if test -n "$dirprev"
        set -l dir
        dirh | sed '$ d' | fzf --ansi -n 2.. +s --tac | \
        sed 's;^ *\([0-9]\{1,\}) *\)\{0,\}/;/;' | read dir
        if test -n "$dir"
            cd $dir
            commandline ''
        end
        commandline -f repaint
    end
end function

bind -M insert \cc cancel_commandline
bind -m insert \cc cancel_commandline
bind -M insert \ch fzf_dir_history
bind -M insert \ej history-token-search-forward
bind -M insert \ek history-token-search-backward
bind -M insert \el nextd-or-forward-word
bind -M insert \eh prevd-or-backward-word
