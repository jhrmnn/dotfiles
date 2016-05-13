#!/usr/bin/env python
from __future__ import print_function
from subprocess import call, Popen, PIPE
import os
import sys
import stat


def install():
    files = Popen(
        'find . -name .git -prune -o -type f ! -name install.*py* -print'.split(),
        stdout=PIPE
    ).communicate()[0].decode().split()
    home = os.path.expanduser('~')
    for path in files:
        print(path)
        target = os.path.abspath(path)
        path = os.path.join(home, path)
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


if __name__ == '__main__':
    path = os.path.dirname(__file__)
    if path:
        os.chdir(path)
    call(
        'curl -ks "https://pub.janhermann.cz/dotfiles/as_targz" | tar -zx --strip-components 1',
        shell=True
    )
    import install as self
    self.install()
    os.chmod('install.py', os.stat('install.py').st_mode | stat.S_IEXEC)
