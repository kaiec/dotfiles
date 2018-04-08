dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:escape']"
ln -sTf ~/dotfiles/config/nvim ~/.config/nvim
ln -sTf ~/dotfiles/config/i3 ~/.config/i3
ln -sTf ~/dotfiles/config/vdirsyncer ~/.config/vdirsyncer
ln -sTf ~/dotfiles/config/i3status ~/.config/i3status
ln -sTf ~/dotfiles/vimrc ~/.vimrc
ln -sTf ~/dotfiles/bashrc ~/.bashrc
mkdir ~/.todo
ln -sTf ~/dotfiles/todo.conf ~/.todo/config
ln -sTf ~/dotfiles/bin/todo.sh ~/bin/todo.sh
ln -sTf ~/dotfiles/profile ~/.profile
ln -sTf ~/dotfiles/bin/screenshot.sh ~/bin/screenshot.sh

