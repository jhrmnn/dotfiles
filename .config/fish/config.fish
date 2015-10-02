set -x PATH $HOME/local/bin $PATH
set -x PATH $HOME/bin $PATH
set -x LD_LIBRARY_PATH $HOME/local/lib:$HOME/local/lib64 $LD_LIBRARY_PATH
set -x PYTHONPATH $HOME/local/lib $PYTHONPATH

alias .. "cd .."
alias ... "cd ../.."
alias ll "ls -l"
alias la "ls -a"
alias lla "ls -la"
alias lt "ls -ltr"
alias py "ptpython"
alias ipy "ptipython"
alias sp "tmux split"
alias vsp "tmux split -h"
alias kp "tmux kill-pane"
alias gitk "gitk --all"
alias make.. "make -C .."

set -x GREP_OPTIONS "--color=auto"

if ls --color=none >/dev/null ^&1
    alias ls "ls -h --color"
else
    alias ls "ls -hG"
end

alias jupy "jupyter notebook"
alias xargs "xargs -o"
alias vpn "sudo vpn"
alias wolfram "/Applications/Mathematica.app/Contents/MacOS/MathKernel"
alias python "python3"

set -x PATH $PATH "/usr/local/sbin"
set -x PATH "/Applications/MATLAB.app/bin" $PATH
set -x PATH $PATH "$HOME/_cache/fhi-aims/bin"
set -x PATH $PATH "$HOME/code/mbd"
set -x PYTHONPATH $PYTHONPATH $HOME/_cache/caffe/python
set -x PYTHONPATH $PYTHONPATH /opt/openbabel/lib/python3.5/site-packages

set -g fish_key_bindings fish_vi_key_bindings

function open -w open
    if count $argv >/dev/null
        command open $argv
    else
        command open .
    end
end

function vim -w vim
    set -l cmd "vim --servername VIM"
    if test (count $argv) -eq 1 -a -d "$argv[1]"
        sh -c "cd $argv[1] && exec $cmd"
    else
        eval command $cmd $argv
    end
end

function vesta
    for f in $argv
        echo -ns \"(realpath $f)\" " "
    end | xargs open -a VESTA
end

function cdf
    set -l target (osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    if test -n $target
        cd $target
        pwd
    else
        echo 'No Finder window found' ^&1
    end
end
