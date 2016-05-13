#!/bin/bash

set -e

for r in $*; do
    echo $r
    ssh $r '.dotfiles/install.py'
done

