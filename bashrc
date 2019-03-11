stty -ixon

COLOR_RED="\033[0;31m"
COLOR_GREEN="\033[0;32m"	
COLOR_YELLOW="\033[0;33m"
COLOR_BLUE="\033[0;34m"
COLOR_RESET="\033[0m"

__git_branch() {
	local status=$(git status 2> /dev/null)
	if [[ -z $status ]]; then return 0; fi

	local re_branch="On branch ([^${IFS}]*)"
	local re_commit="HEAD detached at ([^${IFS}]*)"
	local re_dirty="Changes not staged for commit"
	local re_ahead="Your branch is ahead of '[^${IFS}]*' by ([^${IFS}]*) commit."
	local re_clean="nothing to commit, working tree clean"

	if [[ $status =~ $re_dirty ]]; then
		local color=$COLOR_RED
	elif [[ $status =~ $re_ahead ]]; then
		local ahead=${BASH_REMATCH[1]}\
		local color=$COLOR_YELLOW
	elif [[ $status =~ $re_clean ]]; then
		local color=$COLOR_GREEN
	fi	


	if [[ $status =~ $re_branch ]]; then
	    	local branch=${BASH_REMATCH[1]}
	    	echo -e " $1($color$branch$1)"
	elif [[ $status =~ $re_commit ]]; then
	    	local commit=${BASH_REMATCH[1]}
	    	echo -e " $1($color$commit$1)"
	fi
}

__python_env() {
	if [[ ! -z $VIRTUAL_ENV ]]; then
		echo -e " $1[${VIRTUAL_ENV##*/}]"
	fi
}

export PS1="$COLOR_BLUE┌─ \w\$(__python_env '$COLOR_BLUE')\$(__git_branch '$COLOR_BLUE')\n└─ \\$ \[$COLOR_RESET\]"


# pyenv support
export PATH="/home/kai/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Save current working dir
PROMPT_COMMAND="pwd > ${XDG_RUNTIME_DIR}/.cwd; $PROMPT_COMMAND"


# Aliases
alias gst='git status'
alias gpu='git push'
alias gca='git commit -a'
alias ga='git add'

alias v=vim
alias p=xonsh
alias t="task"
alias stop="task stop"
alias tmail=~/dotfiles/mutt/todo2mail
alias tvim=~/dotfiles/bin/todo2vim
alias a=~/dotfiles/bin/agenda.sh
alias m="notmuch search folder:hdm/INBOX tag:unread | cut -f 3- -d ' '"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ..='cd ..'
alias 1..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


fzf_cd () {
    local fzf_command="/home/kai/.fzf/bin/fzf --height 20"
    if [ $# -gt 0 ]
    then
	    local dir=$(cat ~/dirs | $fzf_command -q $@)
    else
	    local dir=$(cat ~/dirs | $fzf_command)
    fi
    cd $dir
}

alias fcd=fzf_cd

# Autostart

if ! [ -e ~/.is_presentation ]
then
        ~/dotfiles/bin/agenda.sh
fi
