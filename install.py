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
    dotfiles.append('.pam_environment')
    # don't forget xinitrc
    subprocess.call(
        ['ln', '-sf', os.path.join(script_dir, '.xmonad', 'bin', 'xsession'),
        os.path.join(os.path.expanduser('~/'), '.xinitrc')])
    print('ARCH')

# relevant for all distros
for df in dotfiles:
    print(df)
    subprocess.call(
        ['ln', '-snf', os.path.join(script_dir, df),
        os.path.join(os.path.expanduser('~/'), df)])

# link snippets
subprocess.call(
    ['ln', '-snf', os.path.join(script_dir, 'vim/UltiSnips'),
    os.path.join(os.path.expanduser('~/'), '.vim/UltiSnips')])

# set up gnome-terminal
subprocess.call(
    'dconf load '
    '/org/gnome/terminal/legacy/profiles:/:fb7841a7-c0b8-4865-bc81-d365df02b2bc/'
    ' < {}'.format(os.path.join(script_dir, 'base-16-gruvbox-profile.dconf'))
)
