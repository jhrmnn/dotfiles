#!/usr/bin/env python
from __future__ import print_function
import subprocess
import os

files = dict((p.split(os.path.sep, 1)[1], os.path.realpath(p))
             for p in
             subprocess.Popen('find dotfiles -type f'.split(),
                              stdout=subprocess.PIPE)
             .communicate()[0].split())
if os.path.isfile('.gitignore'):
    with open('.gitignore') as f:
        for p in f:
            p = p.strip()
            if os.path.isabs(p):
                p = p[1:]
            if not os.path.isfile(p):
                continue
            files[p] = os.path.realpath(p)
home = os.path.realpath(os.environ['HOME'])
for path, target in files.items():
    path = os.path.join(home, path)
    dirname = os.path.dirname(path)
    if not os.path.isdir(dirname):
        os.makedirs(dirname)
    if os.path.islink(path):
        os.unlink(path)
    os.symlink(os.path.relpath(target, dirname), path)
