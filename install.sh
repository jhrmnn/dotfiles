#!/bin/bash
for f in `git ls-tree --name-only -r HEAD`; do
    case $f in README.md | install.sh ) continue ;; esac
    path=`dirname $f`
    mkdir -p ../$path
    ln -fns `python -c "import os; print os.path.relpath('.dotfiles/$f', '$path')"` ../$f
done
