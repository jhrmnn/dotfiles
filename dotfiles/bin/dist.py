#!/usr/bin/env python3
"""Usage: dist.py [-C DIR] [-c FILE.json] [-p PROFILE] [-h HOST] [CMD]

Options:
    -C DIR
    -h, --host HOST
    -c, --conf FILE.json
    -p, --profile PROFILE
"""
from sh import bash, rsync, git, ssh, tar, rm
import sh
from pathlib import Path
Path.path = property(lambda self: str(self))
import hashlib
from docopt import docopt
import sys
sys.path.append('.')
import json
import subprocess
import os
from contextlib import contextmanager


class Context:
    def __init__(self, **kwargs):
        for k, v in kwargs.items():
            setattr(self, k, v)


@contextmanager
def pushd(path):
    path = str(path)
    cwd = os.getcwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(cwd)


def save_diff(sha, diff):
    archive = '{}.{}.diff.tar.gz'.format(conf.name, sha)
    with open('diff', 'w') as f:
        f.write(diff)
    tar('-zcf', diffs/archive, 'diff')
    rm('diff')
    print('Saved diff to {}.'.format(archive))


def notify(msg):
    from sh import reattach_to_user_namespace
    reattach_to_user_namespace(
        'terminal-notifier', '-message', msg, '-title', conf.name
    )


def get_diff(mainline):
    with sh.pushd(conf.top):
        diff = git.diff(mainline)
    difftext = 'master: {}\n'.format(mainline)
    if diff.strip():
        difftext += str(diff)
        sha = hashlib.sha1(difftext.encode()).hexdigest()
        return sha, difftext
    else:
        return mainline, difftext


def git_rsync(repo, to):
    dirs = set()
    files = []
    for path in git('ls-files', _cwd=repo, _iter=True):
        files.append(path)
        dirs.update(Path(path).parents)
    files.extend('{}\n'.format(path) for path in dirs)
    for line in rsync(*rsync_flags, repo + '/', to, _in=files, _iter=True):
        sys.stdout.write(line)


def get_prefix(branch):
    return dest/'branches'/branch


def build(branch, sha, cmd):
    global dest
    dest = dest.expanduser()
    prefix = get_prefix(branch)
    if hasattr(conf, 'prebuild'):
        ctx = Context(prefix=prefix, dest=dest)
        conf.prebuild(ctx)
    print('Building with `{}`...'.format(cmd))
    with pushd(prefix.path):
        subprocess.check_call(cmd, shell=True)
    if hasattr(conf, 'postbuild'):
        ctx = Context(sha=sha, dest=dest, prefix=prefix, branch=branch)
        conf.postbuild(ctx)


def build_remote(branch, sha, cmd, host):
    print('Connecting to {} to make {} from {}...'.format(host, sha, branch))
    rsync('-a', 'dist_conf.py', '{}:{}'.format(host, dest))
    ssh(host, 'cat >{}/params.json'.format(dest), _in=json.dumps({
        'branch': branch,
        'sha': sha,
        'cmd': cmd
    }))
    subprocess.check_call('ssh -t {} "cd {} && dist.py -c params.json"'.format(
        host, dest
    ), shell=True)
    notify('Finished compiling aims.{} on {}'.format(sha, host))


def dist(host=None, cmd=None, profile=None):
    cmd = cmd or conf.cmd
    with sh.pushd(conf.top):
        branch = git('rev-parse', '--abbrev-ref', 'HEAD').strip()
        mainline = git('merge-base', 'HEAD', 'origin/master').strip()
    if profile:
        branch = '{}:{}'.format(branch, profile)
    sha, diff = get_diff(mainline)
    mainline, sha = mainline[:7], sha[:7]
    if sha != mainline:
        print('Got diff {} of {} with respect to {} (master).'.format(
            sha, branch, mainline
        ))
    else:
        print('On mainline {} (master).'.format(mainline))
    save_diff(sha, diff)
    prefix = get_prefix(branch)
    if host:
        subprocess.call(['ssh', host, ':'])
        print('Syncing {} to {}...'.format(branch, host))
        if hasattr(conf, 'presync'):
            ctx = Context(host=host, dest=dest, git_sync=git_rsync)
            conf.presync(ctx)
        ssh(host, 'mkdir -p {}'.format(prefix))
        git_rsync(conf.top, '{}:{}'.format(host, prefix/conf.top))
        build_remote(branch, sha, cmd, host)
    else:
        prefix = prefix.expanduser()
        prefix.mkdir(exist_ok=True)
        git_rsync(conf.top, prefix/conf.top)
        build(branch, sha, cmd)
        notify('Finished compiling aims.{}'.format(sha))


if __name__ == '__main__':
    args = docopt(__doc__)
    if args['-C']:
        os.chdir(args['-C'])

    import dist_conf as conf
    dest = Path('~/var/Builds')/conf.name
    diffs = Path.home()/'Archive/diffs'
    bash = bash.bake('-c')
    git = git.bake(_tty_out=False)
    shortname = getattr(conf, 'shortname', conf.name)
    rsync_flags = [
        '-ai',
        '--delete-excluded',
        '--include-from=-',
        *('--include=' + patt for patt in getattr(conf, 'include', [])),
        *('--filter=P ' + patt for patt in getattr(conf, 'exclude', [])),
        '--exclude=*'
    ]
    if args['--conf']:
        with open(args['--conf']) as f:
            build(**json.load(f))
    else:
        dist(args['--host'], args['CMD'], profile=args['--profile'])
