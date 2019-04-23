#!/bin/bash

mkdir -p ~/bin

ln -sTf ~/dotfiles/config/nvim ~/.config/nvim
ln -sTf ~/dotfiles/config/kitty ~/.config/kitty
ln -sTf ~/dotfiles/config/i3 ~/.config/i3
ln -sTf ~/dotfiles/config/i3blocks ~/.config/i3blocks
ln -sTf ~/dotfiles/config/polybar ~/.config/polybar
ln -sTf ~/dotfiles/config/vdirsyncer ~/.config/vdirsyncer
ln -sTf ~/dotfiles/config/i3status ~/.config/i3status
ln -sTf ~/dotfiles/config/rofi ~/.config/rofi
ln -sTf ~/dotfiles/config/conky ~/.config/conky
ln -sTf ~/dotfiles/config/flake8 ~/.config/flake8
ln -sTf ~/dotfiles/config/powerline-shell ~/.config/powerline-shell
ln -sTf ~/dotfiles/config/mimeapps.list ~/.config/mimeapps.list
ln -sTf ~/dotfiles/config/mimeapps.list ~/.local/share/applications/mimeapps.list
ln -sTf ~/dotfiles/vimrc ~/.vimrc
ln -sTf ~/dotfiles/bashrc ~/.bashrc
ln -sTf ~/dotfiles/inputrc ~/.inputrc
ln -sTf ~/dotfiles/zshrc ~/.zshrc
ln -sTf ~/dotfiles/urxvt ~/.urxvt
ln -sTf ~/dotfiles/xonshrc ~/.xonshrc
ln -sTf ~/dotfiles/config/xonsh/ ~/.config/xonsh
ln -sTf ~/dotfiles/Xdefaults ~/.Xdefaults
ln -sTf ~/dotfiles/mailcap ~/.mailcap
mkdir -p ~/.todo
ln -sTf ~/dotfiles/todo.conf ~/.todo/config
ln -sTf ~/dotfiles/bin/todo.sh ~/bin/todo.sh
ln -sTf ~/dotfiles/todotxt-machinerc ~/.todotxt-machinerc
ln -sTf ~/dotfiles/profile ~/.profile
ln -sTf ~/dotfiles/screenlayout ~/.screenlayout
ln -sTf ~/dotfiles/bin/screenshot.sh ~/bin/screenshot.sh
ln -sTf ~/dotfiles/bin/cwd.sh ~/bin/cwd.sh
ln -sTf ~/dotfiles/bin/toggle-pad.sh ~/bin/toggle-pad.sh
ln -sTf ~/dotfiles/bin/caps.sh ~/bin/caps.sh
ln -sTf ~/dotfiles/bin/nocaps ~/bin/nocaps
ln -sTf ~/dotfiles/bin/beamer-optimizer.sh ~/bin/beamer-optimizer.sh
ln -sTf ~/dotfiles/bin/mutt-mailboxes.py ~/bin/mutt-mailboxes.py
ln -sTf ~/dotfiles/bin/unread ~/bin/unread
ln -sTf ~/dotfiles/muttrc ~/.muttrc
mkdir -p ~/.mutt
touch ~/.mutt/aliases
ln -sTf ~/dotfiles/mutt/gpg.rc ~/.mutt/gpg.rc
ln -sTf ~/dotfiles/mutt/gruvbox-transparent.conf ~/.mutt/gruvbox-transparent.conf
ln -sTf ~/dotfiles/offlineimaprc ~/.offlineimaprc
mkdir -p ~/.offlineimap
ln -sTf ~/dotfiles/offlineimap/confhelpers.py ~/.offlineimap/confhelpers.py
ln -sTf ~/dotfiles/mbsynrc ~/.mbsyncrc
ln -sTf ~/dotfiles/msmtprc ~/.msmtprc
ln -sTf /usr/share/doc/msmtp/msmtpq/msmtp-queue ~/bin/msmtp-queue
ln -sTf /usr/share/doc/msmtp/msmtpq/msmtpq ~/bin/msmtpq
ln -sTf ~/dotfiles/notmuch-config ~/.notmuch-config
mkdir -p ~/.msmtp.queue
chmod 0700 ~/.msmtp.queue
mkdir -p ~/log
ln -sTf ~/dotfiles/bin/mail ~/bin/mail
ln -sTf ~/dotfiles/bin/reveal ~/bin/reveal
ln -sTf ~/dotfiles/bin/poll-stuff.sh ~/bin/poll-stuff.sh
ln -sTf ~/dotfiles/bin/today ~/bin/today
ln -sTf ~/dotfiles/bin/soon ~/bin/soon
ln -sTf ~/dotfiles/bin/printics ~/bin/printics
ln -sTf ~/dotfiles/bin/camtoggle ~/bin/camtoggle
ln -sTf ~/dotfiles/bin/screencast ~/bin/screencast
ln -sTf ~/dotfiles/bin/killrecording ~/bin/killrecording
ln -sTf ~/dotfiles/bin/tt ~/bin/tt
ln -sTf ~/dotfiles/bin/start ~/bin/start
ln -sTf ~/dotfiles/bin/remotevim ~/bin/remotevim
ln -sTf ~/dotfiles/bin/vfat ~/bin/vfat
ln -sTf ~/dotfiles/bin/togglenotes ~/bin/togglenotes
ln -sTf ~/dotfiles/compton.conf ~/.config/compton.conf
# Task warrior
command -v task >/dev/null || echo "Task Warrior is not installed"
mkdir -p ~/.timewarrior
if [ -f ~/Dropbox/Notizen/tasks ]; then
	ln -sTf ~/dotfiles/task/hooks ~/Dropbox/Notizen/tasks/hooks
else
	echo "No Dropbox files, could not install taskwarrior hooks."
fi
ln -sTf ~/dotfiles/task/taskrc ~/.taskrc
ln -sTf ~/dotfiles/task/taskopenrc ~/.taskopenrc
ln -sTf ~/dotfiles/task/timewarrior/timewarrior.cfg ~/.timewarrior/timewarrior.cfg
ln -sTf ~/dotfiles/task/timewarrior/extensions ~/.timewarrior/extensions
ln -sTf ~/dotfiles/bin/ttime ~/bin/ttime
ln -sTf ~/dotfiles/bin/create-fzf-dirs ~/bin/create-fzf-dirs
ln -sTf ~/dotfiles/bin/tm ~/bin/tm
ln -sTf ~/dotfiles/bin/tca ~/bin/tca

hash pyenv 2>/dev/null || echo "Pyenv is not installed"
