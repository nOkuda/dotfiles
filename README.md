# Nozomu's dotfiles

## Setting up gnome-terminal

[This gist](https://gist.github.com/reavon/0bbe99150810baa5623e5f601aa93afc) was helpful.

## Disable Dash to Dock Keyboard Shortcuts

<https://github.com/micheleg/dash-to-dock/issues/914#issuecomment-694123022>:

`for i in {1..9}; do gsettings set org.gnome.shell.keybindings switch-to-application-$i "[]"; done`
