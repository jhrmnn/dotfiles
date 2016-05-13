#!/usr/bin/env python
from __future__ import print_function
from subprocess import call, Popen, PIPE
import os
import sys
import stat


def install():
    files = Popen(
        'find dotfiles -type f'.split(), stdout=PIPE
    ).communicate()[0].decode().split()
    home = os.path.expanduser('~')
    for path in files:
        target = os.path.abspath(path)
        path = os.path.join(home, path.split(os.path.sep, 1)[1])
        print(path)
        dirname = os.path.dirname(path)
        target = os.path.relpath(target, dirname)
        if not os.path.isdir(dirname):
            os.makedirs(dirname)
        if os.path.islink(path):
            os.unlink(path)
        try:
            os.symlink(target, path)
        except Exception:
            print('error: Cannot symlink to {0}'.format(path))
            sys.exit(1)
    call(['fish', '-c', 'source ~/.config/fish/init.fish'])
    call(
        'mkdir -p ~/.vim && ln -fns ../.config/nvim/autoload ~/.vim/autoload',
        shell=True
    )


if __name__ == '__main__':
    path = os.path.dirname(__file__)
    if path:
        os.chdir(path)
    call(
        'curl -ks "https://pub.janhermann.cz/dotfiles/dotfiles/as_targz" | tar -zx',
        shell=True
    )
    import install as self
    self.install()
    os.chmod('install.py', os.stat('install.py').st_mode | stat.S_IEXEC)
