#!/bin/bash
echo "------- AGENDA ------"
khal list
# ~/dotfiles/bin/todo.sh due 3
#task due.before:3d 2>/dev/null
echo
echo "------- TODO --------"
# ~/dotfiles/bin/todo.sh -pP lsp A
task next limit:10 2> /dev/null
echo "---------------------"
echo
echo "Mails in Inbox: " $(notmuch count folder:hdm/INBOX tag:unread)"/"$(notmuch count folder:hdm/INBOX)
TOBESENT=$(msmtp-queue | grep -c id=)
if [ $TOBESENT -ne 0 ]
then
	echo "Mails to be sent: " $TOBESENT 
fi
