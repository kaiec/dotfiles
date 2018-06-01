## Deactivate flow control (ctrl s)
Put this in .bashrc

    stty -ixon


## Remapping Caps Lock
### Ubuntu
Run

    dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"

## Time zone change
While traveling, the time zone can be changed like this:

    timedatectl set-timezone Europe/Paris
