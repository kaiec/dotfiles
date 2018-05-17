dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
ln -sTf ~/dotfiles/config/nvim ~/.config/nvim
ln -sTf ~/dotfiles/config/i3 ~/.config/i3
ln -sTf ~/dotfiles/config/polybar ~/.config/polybar
ln -sTf ~/dotfiles/config/vdirsyncer ~/.config/vdirsyncer
ln -sTf ~/dotfiles/config/i3status ~/.config/i3status
ln -sTf ~/dotfiles/config/rofi ~/.config/rofi
ln -sTf ~/dotfiles/config/flake8 ~/.config/flake8
ln -sTf ~/dotfiles/config/powerline-shell ~/.config/powerline-shell
ln -sTf ~/dotfiles/vimrc ~/.vimrc
ln -sTf ~/dotfiles/bashrc ~/.bashrc
ln -sTf ~/dotfiles/urxvt ~/.urxvt
ln -sTf ~/dotfiles/Xdefaults ~/.Xdefaults
mkdir ~/.todo
ln -sTf ~/dotfiles/todo.conf ~/.todo/config
ln -sTf ~/dotfiles/bin/todo.sh ~/bin/todo.sh
ln -sTf ~/dotfiles/profile ~/.profile
ln -sTf ~/dotfiles/screenlayout ~/.screenlayout
ln -sTf ~/dotfiles/bin/screenshot.sh ~/bin/screenshot.sh
ln -sTf ~/dotfiles/bin/cwd.sh ~/bin/cwd.sh
ln -sTf ~/dotfiles/bin/toggle-pad.sh ~/bin/toggle-pad.sh
ln -sTf ~/dotfiles/bin/caps.sh ~/bin/caps.sh
ln -sTf ~/dotfiles/bin/beamer-optimizer.sh ~/bin/beamer-optimizer.sh
ln -sTf ~/dotfiles/bin/mutt-mailboxes.py ~/bin/mutt-mailboxes.py
ln -sTf ~/dotfiles/muttrc ~/.muttrc
ln -sTf ~/dotfiles/offlineimaprc ~/.offlineimaprc
mkdir ~/.offlineimap
ln -sTf ~/dotfiles/offlineimap/confhelpers.py ~/.offlineimap/confhelpers.py
ln -sTf ~/dotfiles/msmtprc ~/.msmtprc
ln -sTf ~/dotfiles/notmuch-config ~/.notmuch-config
mkdir ~/.msmtp.queue
chmod 0700 ~/.msmtp.queue
mkdir ~/log
ln -sTf ~/dotfiles/bin/mail ~/bin/mail
ln -sTf ~/dotfiles/bin/reveal ~/bin/reveal
