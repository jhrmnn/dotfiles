#!/bin/bash

set -e

for r in $*; do
    echo $r
    ssh $r \
        'rm -rf .dotfiles .vim && \
        mkdir .dotfiles && \
        cd .dotfiles && \
        curl -ks https://pub.janhermann.cz/static/dotfiles/install.py >install.py && \
        PATH=$PATH:~/local/bin LD_LIBRARY_PATH=~/local/lib:~/local/lib64 python install.py'
done
