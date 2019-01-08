if command ls --color=none >/dev/null ^&1
    function ls --wraps=ls
        command ls -h --color $argv
    end
else
    function ls --wraps=ls
        command ls -hG $argv
    end
end


