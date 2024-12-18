
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# TMUX
# if which tmux >/dev/null 2>&1; then
#     #if not inside a tmux session, and if no session is started, start a new session
#     test -z "$TMUX" && { exec tmux new-session && exit 0; }
# fi
# 
# setterm --linewrap off

source ~/.env-secrets


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

export PS1="$COLOR_GREEN┌─ \w\$(__python_env '$COLOR_GREEN')\$(__git_branch '$COLOR_GREEN')\n└─ \\$ \[$COLOR_RESET\]"


# pyenv support
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Save current working dir
PROMPT_COMMAND="pwd > ${XDG_RUNTIME_DIR}/.cwd; $PROMPT_COMMAND"

# Change to saved working dir
[[ -f "${XDG_RUNTIME_DIR}/.cwd" ]] && [[ $PWD == ~ ]] && cd "$(< ${XDG_RUNTIME_DIR}/.cwd)"

# check the window size after each command and, 
# if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Bash Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Aliases
alias gst='git status'
alias gpu='git push'
alias gca='git commit -a'
alias ga='git add'

command -v nvim > /dev/null && alias vim=nvim
alias v=vim

alias emacs="emacsclient -c "
alias e=emacs

alias fspdf='~/daten/projekte/fspdf/fspdf-runner.py'
alias vimdiff='nvim -d'

# TASK WARRIOR


alias p=python
alias t="task"
alias in="task add +inbox"
alias stop='twtool stop'
alias start='twtool start'
alias tmail=~/dotfiles/mutt/todo2mail
alias tvim=~/dotfiles/bin/todo2vim
alias a=~/dotfiles/bin/agenda.sh
alias m="notmuch search folder:hdm/INBOX tag:unread | cut -f 3- -d ' '"
alias pm='python manage.py'

_taskopen() {
	if [[ -z $1 ]]; then 
		/usr/bin/taskopen '+ACTIVE'
	else
		/usr/bin/taskopen "$1"
	fi
}
alias taskopen=_taskopen

n() {
	pushd ~/daten/notizen/
	vim $1.md
	popd
}

# alias ls='ls --group-directories-first'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ldl='ls -Alt ~/Downloads | head -n 10'

alias ..='cd ..'
alias 1..='cd ..'
alias 2..='cd ../..'
alias 3..='cd ../../..'
alias 4..='cd ../../../..'
alias 5..='cd ../../../../..'

_mutt(){
	pushd ~/attachments > /dev/null
	/usr/bin/neomutt $@
	popd > /dev/null
}
alias mutt='_mutt -F ~/dotfiles/mutt/muttrc-hsma'
alias mgen='_mutt -F ~/dotfiles/mutt/muttrc-gen'
alias mhs='_mutt -F ~/dotfiles/mutt/muttrc-hsma'
alias mhdm=_mutt
alias mhallo='_mutt -F ~/dotfiles/mutt/muttrc-hallo'
alias mkep='_mutt -F ~/dotfiles/mutt/muttrc-kep'
alias mflokai='_mutt -F ~/dotfiles/mutt/muttrc-flokai'

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


fzf_cd () {
    local fzf_command="fzf --height 20"
    if [ $# -gt 0 ]
    then
	    local dir=$(cat ~/.fzfdirs | $fzf_command -q $@)
    else
	    local dir=$(cat ~/.fzfdirs | $fzf_command)
    fi
    cd "$dir"
}

alias fcd=fzf_cd

# History

shopt -s histappend
shopt -s extglob

HISTFILESIZE=1000000
HISTSIZE=1000000
HISTCONTROL="ignoreboth:erasedups"
HISTTIMEFORMAT='%F %T '
HISTIGNORE='@(?|??|???):ls -l:ls -la:ls -lh:ls -lah:clear:history*:exit:t *:cd ..'

shopt -s cmdhist

# this must only be done in interactive shells.
stty -ixon


# 
# Autostart
# if ! [ -e ~/.is_presentation ]
# then
# 	~/dotfiles/bin/agenda.sh
# fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kai/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kai/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kai/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kai/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


source /home/kai/.config/broot/launcher/bash/br

export SDL_VIDEO_X11_NET_WM_BYPASS_COMPOSITOR=0


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

source $HOME/.config/plasma-workspace/env/environment.sh

export PATH="$PATH:/home/kai/bin"
