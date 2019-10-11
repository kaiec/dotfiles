#!/bin/bash
function __showcal {
	khal --color list `date +"%Y-%m-%d"` `date --date="1 days" +"%Y-%m-%d"`
	# ~/dotfiles/bin/todo.sh due 3
	#task due.before:3d 2>/dev/null
}

function __showtasks {
	# ~/dotfiles/bin/todo.sh -pP lsp A
	task rc._forcecolor=on next limit:10 | sed "/^$/d" 2> /dev/null
}

function __showmail {
	notmuch new --quiet
	echo "HdM: " $(notmuch count folder:hdm/Inbox tag:unread)"/"$(notmuch count folder:hdm/Inbox)
	echo "KE-P: " `unread kep`
	echo "Privat 1: " `unread hallo/Inbox`
	echo "Privat 2: " `unread flokai/Inbox`
	echo "Gen: " `unread gen/Inbox`
	TOBESENT=$(msmtp-queue | grep -c id=)
	if [ $TOBESENT -ne 0 ]
	then
		echo "QUEUED: " $TOBESENT 
	fi

}

function __showunsaved {
	swaps=$(find ~/.local/share/nvim/swap -type f -name '%home%kai%Dropbox%Notizen%*.sw?') 
	if [[ -z $swaps ]]; then
		return
	fi
	echo -n 'Unsaved notes: '
	echo $swaps| sed 's/.*Notizen%//' | sed 's#%#/#g;s/\.sw.$//' | uniq | paste -sd '%' - | sed 's/%/, /g'
}

function __showunsavedlist {
	swaps=$(find ~/.local/share/nvim/swap -type f -name '%home%kai%Dropbox%Notizen%*.sw?') 
	if [[ -z $swaps ]]; then
		return
	fi
	echo $swaps| sed 's/.*Notizen%//' | sed 's#%#/#g;s/\.sw.$//' | uniq 
}
if [[ -z $1 ]]; then
	echo "------- AGENDA ------"
	command -v khal > /dev/null && __showcal
	echo
	echo "------- TODO --------"
	command -v task > /dev/null && __showtasks
	echo "---------------------"
	echo
	command -v notmuch > /dev/null && __showmail

	if [[ -d ~/Dropbox/Notizen/ ]]; then
		echo
		__showunsaved
	fi
else
	$1
fi
