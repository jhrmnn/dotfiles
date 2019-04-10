import os
import subprocess
import sys

c = get_config()
c.NotebookApp.iopub_data_rate_limit = 10_000_000
