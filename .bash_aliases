#!/bin/bash

alias ..='cd ..'
alias ...='cd ../..' 
alias pd="pushd"
alias up="pushd .."
alias upp="pushd ../.."
alias uppp="pushd ../../.."
alias po="popd"
alias cdf='cd `find . -mindepth 1 -maxdepth 1 -type d | head -n 1`'

alias ls="ls -h --color"
alias l="ls"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lx="ls -xb"   # sort by extension
alias lk="ls -lSr"  # sort by size, biggest last
alias lc="ls -ltcr" # sort by and show change time, most recent last
alias lu="ls -ltur" # sort by and show access time, most recent last
alias lt="ls -ltr"  # sort by date, most recent last

alias vi="vim"
alias v="vim"
alias dush="du -sm * | sort -rn"
alias matlab="matlab -nojvm"
alias py='ptpython --vi'

alias qher='qstat -f | grep -B 1 jhermann | egrep "jhermann|BIP"'
