#!/bin/bash
function __showcal {
	echo "------- AGENDA ------"
	khal list `date +"%Y-%m-%d"` `date --date="1 days" +"%Y-%m-%d"`
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
	notmuch new --quiet
	echo
	echo "Mails in Inbox: " $(notmuch count folder:hdm/Inbox tag:unread)"/"$(notmuch count folder:hdm/Inbox)
	TOBESENT=$(msmtp-queue | grep -c id=)
	if [ $TOBESENT -ne 0 ]
	then
		echo "Mails to be sent: " $TOBESENT 
	fi
	echo "KE-P: " `unread kep`
	echo "Privat 1: " `unread hallo/Inbox`
	echo "Privat 2: " `unread flokai/Inbox`
	echo "Gen: " `unread gen/Inbox`

}

function __showunsaved {
	swaps=$(find ~/.local/share/nvim/swap -type f -name '%home%kai%Dropbox%Notizen%*.sw?') 
	if [[ -z $swaps ]]; then
		return
	fi
	echo
	echo -n 'Unsaved notes: '
	echo $swaps| sed 's/.*Notizen%//' | sed 's#%#/#g;s/\.sw.$//' | uniq | paste -sd '%' - | sed 's/%/, /g'
}

command -v khal > /dev/null && __showcal
command -v task > /dev/null && __showtasks
command -v notmuch > /dev/null && __showmail

if [[ -d ~/Dropbox/Notizen/ ]]; then
	__showunsaved
fi
