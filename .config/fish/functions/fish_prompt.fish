function fish_prompt
    set -l _status $status
    if [ -n "$POETRY_ACTIVE" ]
        echo -ns "(" (basename $VIRTUAL_ENV) ") "
    end
    echo -ns (date "+%H:%M")
    set_color normal
    if [ -n "$SSH_CLIENT" -o -n "$SSH_CLIENT2" ]
        if not set -q __fish_prompt_hostname
            set -g __fish_prompt_hostname (prompt_hostname)
        end
        echo -ns " " (set_color brred) $USER \
        (set_color brcyan) "@" (set_color brred) $__fish_prompt_hostname
    end
    echo -ns " " (set_color -o cyan) (prompt_pwd)
    if [ $PROMPT_PREFIX ]
        echo -ns (set_color -o magenta) " {$PROMPT_PREFIX}"
    end
    if git rev-parse --is-inside-work-tree >/dev/null ^&1
        set_color -o (if git status --porcelain | egrep . >/dev/null ^&1; echo yellow; else; echo green; end)
        __fish_git_prompt
    end
    set -l njobs (jobs | wc -l | string trim)
    if [ $njobs -gt 0 ]
        echo -ns (set_color -o blue) " $njobs"
    end
    if [ $_status -ne 0 ]
        echo -ns (set_color -o red) " [$_status]"
    end
    echo -ns (set_color normal)
    switch $fish_bind_mode
        case visual
            echo -ns " 🐠 "
        case '*'
            echo -ns " 🐟 "
    end
end
