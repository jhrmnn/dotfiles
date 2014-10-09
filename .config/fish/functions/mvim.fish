function mvim
    if test (count "$argv") -gt 0 -a -d "$argv[-1]"
        set -l path $argv[-1]
        if test (count "$argv") -gt 1
            set argv $argv[1..-2]
        else
            set argv
        end
        bash -c "cd $path; mvim $argv"
    else
        command mvim $argv
    end
end

