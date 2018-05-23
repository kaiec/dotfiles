#!/bin/bash
echo "------ TERMINE ------"
khal list
echo
echo "------- TODO --------"
~/dotfiles/bin/todo.sh -pP lsp A
echo "---------------------"
echo
