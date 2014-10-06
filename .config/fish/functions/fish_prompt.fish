function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set_color $fish_color_user; echo -n (whoami)
    set_color black; echo -n '@'
    set_color $fish_color_host; echo -n (hostname -s)
    set_color normal; echo -n ' '
    set_color $fish_color_cwd; echo -n (prompt_pwd)
    set_color normal; __my_git_prompt
    set_color normal; echo -n ' '
    if not test $last_status -eq 0
        set_color -o $fish_color_error
        echo -n "[$last_status]"
    else
        set_color black
    end
    echo -n '$ '
    set_color normal
end

function __my_git_prompt
    if not git status >/dev/null ^&1
        return
    end
    set -l branch (git rev-parse --abbrev-ref HEAD)
    echo -n ' '
    if git status --porcelain | egrep . >/dev/null
        set_color -o red
    else
        set_color green
    end
    echo -n $branch
    set_color normal
end
