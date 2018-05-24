#!/bin/bash
echo "------- AGENDA ------"
khal list
~/dotfiles/bin/todo.sh due 3
echo
echo "------- TODO --------"
~/dotfiles/bin/todo.sh -pP lsp A
echo "---------------------"
echo
echo "Mails in Inbox: " $(notmuch count folder:hdm/INBOX tag:unread)"/"$(notmuch count folder:hdm/INBOX)
