#!/bin/bash
mkdir bundle
cd bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cd ..
vim +PluginInstall +qall
