function fish_prompt
    set _status $status

    set_color normal

    echo -ns (date "+%H:%M")

    if [ -n "$SSH_CLIENT" -o -n "$SSH_CLIENT2" -o -z "$PROMPT_NO_USER" ]
        echo -ns " "
    end
    if [ -z "$PROMPT_NO_USER" ]
        echo -ns (set_color de935f) $USER
    end
    if [ -n "$SSH_CLIENT" -o -n "$SSH_CLIENT2" ]
        if not set -q __fish_prompt_hostname
            set -g __fish_prompt_hostname (prompt_hostname)
        end
        echo -ns (set_color brblack) "@" (set_color de935f) $__fish_prompt_hostname
    end

    if [ -n "$PROMPT_PATH_ROOT" ]
        set path_root $PROMPT_PATH_ROOT
        set root_symbol "{"(basename $PROMPT_PATH_ROOT)"}"
    else
        set path_root ~
        set root_symbol '~'
    end
    set mypwd (string replace -r '^'"$path_root"'($|/)' '!!$1' $PWD)
    set mypwd (string replace -ar '(\.?[^/]{2})[^/]*/' '$1/' $mypwd)
    set mypwd (string replace -r '^!!($|/)' (set_color -o green)"$root_symbol"(set_color -o cyan)'$1' $mypwd)
    echo -ns " " (set_color -o cyan) $mypwd

    if begin [ -z "$NO_GIT_PROMPT" ]; or string match -rv "$NO_GIT_PROMPT" $PWD >/dev/null; end
        set_color -o (if git status --porcelain 2>/dev/null | egrep . >/dev/null 2>&1; echo yellow; else; echo green; end)
        __fish_git_prompt
    end

    set njobs (jobs | wc -l | string trim)
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
