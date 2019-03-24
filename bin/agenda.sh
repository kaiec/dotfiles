#!/bin/bash
function __showcal {
	echo "------- AGENDA ------"
	khal list
	# ~/dotfiles/bin/todo.sh due 3
	#task due.before:3d 2>/dev/null
	echo
}

function __showtasks {
	echo "------- TODO --------"
	# ~/dotfiles/bin/todo.sh -pP lsp A
	task next limit:10 2> /dev/null
	echo "---------------------"

}

function __showmail {
	echo
	echo "Mails in Inbox: " $(notmuch count folder:hdm/INBOX tag:unread)"/"$(notmuch count folder:hdm/INBOX)
	TOBESENT=$(msmtp-queue | grep -c id=)
	if [ $TOBESENT -ne 0 ]
	then
		echo "Mails to be sent: " $TOBESENT 
	fi

}

command -v khal > /dev/null && __showcal
command -v task > /dev/null && __showtasks
command -v notmuch > /dev/null && __showmail
