Various configuration files I use across all machines I have access to.

## Requirements

Requires [mosh](http://mosh.mit.edu/) (HEAD version from github because of mouse event passing), `tmux` and [fish](http://fishshell.com/) (HEAD version from github because of vi mode)

## Install

```fish
git clone https://github.com/azag0/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
fish install.fish
```

[Vundle](https://github.com/gmarik/Vundle.vim) package manager for Vim has to be installed by hand and plugins installed from Vim with `:PluginInstall`

