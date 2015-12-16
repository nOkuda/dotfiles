#!/usr/bin/python

import os
import subprocess

dotfiles = [
        '.vimrc',
        '.tmux.conf'
        ]
script_dir = os.path.dirname(os.path.realpath(__file__))
for df in dotfiles:
    subprocess.call(['ln', '-sf', os.path.join(script_dir, df),
            os.path.join(os.path.expanduser('~/'), df)])

