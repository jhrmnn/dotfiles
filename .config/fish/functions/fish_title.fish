function fish_title
    set -l len $fish_prompt_pwd_dir_length
    set -g fish_prompt_pwd_dir_length 0
    prompt_pwd
    set -g fish_prompt_pwd_dir_length $len
    echo ' — '
    if test -z "$argv"
        echo $_
    else
        echo $argv
    end
end

