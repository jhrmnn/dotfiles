#!/bin/bash

set -e

for r in $*; do
    ssh $r '.dotfiles/install.py >/dev/null' && echo "$r done" || echo "$r failed" &
done
wait

