set -l skip README.md install.fish
for f in (git ls-tree --name-only -r HEAD)
    if contains $f $skip
        continue
    end
    set -l path (dirname $f)
    mkdir -p ../$path
    set -l cmd ln -fns (python -c "import os; print os.path.relpath('.dotfiles/$f', '$path')") ../$f
    echo $cmd
    eval $cmd
end
