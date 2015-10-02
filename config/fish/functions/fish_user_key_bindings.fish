fzf_key_bindings

function new-line
    if test -n (commandline)
        echo "^C"
    else
        echo
    end
    commandline ""
    commandline -f force-repaint
end

bind -M insert \cc new-line
bind -M default -m insert \cc new-line
