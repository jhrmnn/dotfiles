Various configuration files I use across all machines I have access to.

## Dependencies

- [mosh](http://mosh.mit.edu/) (HEAD version from github because of mouse event passing)
- `tmux`
- [fish](http://fishshell.com/) (HEAD version from github because of vi mode).

Also, you should have [Vundle](https://github.com/gmarik/Vundle.vim) installed in `~/.vim/bundle/Vundle.vim`. You can have that with

```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Install

```bash
git clone https://github.com/azag0/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
fish install.fish
```

Also, you probably want to change your name and email in `.gitconfig`
