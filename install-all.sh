#!/bin/bash

set -e

for r in $*; do
    ssh $r '\
        rm -rf .dotfiles .vim && \
        rm -rf .config/nvim/autoload/plug.vim .local/share/nvim/plugged && \
        mkdir .dotfiles && \
        cd .dotfiles && \
        curl -ks https://pub.janhermann.cz/static/dotfiles/install.py >install.py && \
        PATH=$PATH:~/local/bin LD_LIBRARY_PATH=~/local/lib:~/local/lib64 python install.py' \
        && echo "$r done" || echo "$r failed" &
done
wait
