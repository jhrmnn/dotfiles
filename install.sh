#!/bin/bash
for f in $(cd dotfiles && find . -type f); do
    path=`dirname $f`
    mkdir -p ../$path
    ln -fns `python -c "import os; print os.path.relpath('.dotfiles/dotfiles/$f', '$path')"` ../$f
done
if [ -r .gitignore ]; then
    for f in $(cat .gitignore); do
        path=`dirname $f`
        mkdir -p ../$path
        ln -fns `python -c "import os; print os.path.relpath('.dotfiles/$f', '$path')"` ../$f
    done
fi
