#!/usr/bin/env python
from __future__ import print_function
import subprocess
import os

files = {p.split(os.path.sep, 1)[1]: os.path.realpath(p)
         for p in subprocess.check_output('find dotfiles -type f'.split()).split()}
if os.path.isfile('.gitignore'):
    with open('.gitignore') as f:
        for p in f:
            p = p.strip()
            if os.path.isabs(p):
                p = p[1:]
            files[p] = os.path.realpath(p)
for path, target in files.items():
    path = os.path.join(os.environ['HOME'], path)
    dirname = os.path.dirname(path)
    if not os.path.isdir(dirname):
        os.makedirs(dirname)
    if os.path.islink(path):
        os.unlink(path)
    os.symlink(os.path.relpath(target, dirname), path)
