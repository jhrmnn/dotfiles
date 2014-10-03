function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set_color $fish_color_user; echo -n (whoami)
    set_color normal; echo -n '@'
    set_color $fish_color_host; echo -n (hostname -s)
    set_color normal; echo -n ' '
    set_color $fish_color_cwd; echo -n (prompt_pwd)
    set_color normal; __terlar_git_prompt
    set_color normal; echo -n ' '
    if not test $last_status -eq 0
        set_color -o $fish_color_error
        echo -n "[$last_status]"
    else
        set_color normal
    end
    echo -n '$ '
    set_color normal
end
