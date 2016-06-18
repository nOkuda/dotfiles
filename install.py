import os
import subprocess

dotfiles = [
    '.vimrc',
    '.tmux.conf']
script_dir = os.path.dirname(os.path.realpath(__file__))

p_uname = subprocess.Popen(['uname', '-r'],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    universal_newlines=True)
output, err = p_uname.communicate()
if 'ARCH' in output:
    dotfiles.append('.xmonad')
    dotfiles.append('.xbindkeysrc')
    # don't forget xinitrc
    subprocess.call(
        ['ln', '-sf', os.path.join(script_dir, '.xmonad', 'bin', 'xsession'),
        os.path.join(os.path.expanduser('~/'), '.xinitrc')])

# relevant for all distros
for df in dotfiles:
    subprocess.call(
        ['ln', '-sf', os.path.join(script_dir, df),
        os.path.join(os.path.expanduser('~/'), df)])

