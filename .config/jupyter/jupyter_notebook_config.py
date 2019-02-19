import os
import sys
import subprocess


def post_save(model, os_path, contents_manager):
    if model['type'] != 'notebook':
        return
    if model['name'] == 'Untitled.ipynb':
        return
    d, filename = os.path.split(os_path)
    subprocess.check_call(
        [sys.executable, '-m', 'jupyter', 'nbconvert', '--to', 'script', filename],
        cwd=d
    )


c = get_config()
c.FileContentsManager.post_save_hook = post_save
c.NotebookApp.iopub_data_rate_limit = 10000000
if sys.platform == 'darwin':
    c.NotebookApp.browser = 'open -a Firefox %s'
