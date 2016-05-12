#!/usr/bin/env python
from __future__ import print_function
import subprocess
import os
import sys


links = {
    '.vim': '.local/share/nvim',
    '.vim/autoload': '.config/nvim/autoload'
}


os.chdir(os.path.dirname(__file__))
subprocess.call(
    'curl -ks "https://pub.janhermann.cz/dotfiles/dotfiles/as_targz" | tar -zx',
    shell=True
)
files = dict(
    (p.split(os.path.sep, 1)[1], os.path.abspath(p))
    for p in subprocess.Popen(
        'find dotfiles -type f -o -type l'.split(),
        stdout=subprocess.PIPE
    ).communicate()[0].split()
)
files.update(links)
if os.path.isfile('.gitignore'):
    with open('.gitignore') as f:
        for p in f:
            p = p.strip()
            if os.path.isabs(p):
                p = p[1:]
            if not os.path.isfile(p):
                continue
            files[p] = os.path.abspath(p)
home = os.path.realpath(os.environ['HOME'])
for path, target in files.items():
    is_link = path in links
    path = os.path.join(home, path)
    dirname = os.path.dirname(path)
    if not os.path.isdir(dirname):
        os.makedirs(dirname)
    if os.path.islink(path):
        os.unlink(path)
    if is_link:
        target = os.path.join(home, target)
    else:
        target = os.path.relpath(target, dirname)
    try:
        os.symlink(target, path)
    except Exception:
        print('error: Cannot symlink to {0}'.format(path))
        sys.exit(1)
