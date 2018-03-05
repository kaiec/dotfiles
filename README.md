## Deactivate flow control (ctrl s)
Put this in .bashrc
  stty -ixon


## Remapping Caps Lock
### Ubuntu
Run
  dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
