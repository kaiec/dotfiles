# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
  export ZSH="/home/kai/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"
DEFAULT_USER="kai"
prompt_context(){}

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  pyenv
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs time pyenv)

#
#
# pyenv support
export PATH="/home/kai/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export EDITOR=nvim
HISTIGNORE="$HISTIGNORE:jrnl *"
HISTIGNORE="$HISTIGNORE:t a*"

export TODOTXT_DEFAULT_ACTION=ls
alias t="todo.sh -a -t"
alias todo=todotxt-machine
alias plan="todo.sh pom plan"
alias start="date;todo.sh pom start"
export POMODORO_SECONDS=1500 # 25*60
export POMODORO_SIG_SIGNAL=3
export POMODORO_SIG_PROCESS=i3blocks


# gcalcli agenda --military $(date +%D) $(date -d '1 days' +%D)
if ! [ -e ~/.is_presentation ]
then
	~/dotfiles/bin/agenda.sh
fi
alias a=~/dotfiles/bin/agenda.sh
alias m="notmuch search folder:hdm/INBOX tag:unread | cut -f 3- -d ' '"

alias gst='git status'
alias gpu='git push'
alias gca='git commit -a'
alias ga='git add'
alias v=vim


# Change to last directory.
# Should work as follows:
# In i3 for a new terminal cwd.sh is invoked which tries to find
# the cwd of the currently focussed terminal window if any.
# if this does not work, i.e., the terminal is in home directory,
# the last saved cwd is used based on this approach:
# 
# https://faq.i3wm.org/question/150/how-to-launch-a-terminal-from-here/%3C/p%3E.html
# 
# 
# Save current working dir
PROMPT_COMMAND="pwd > ${XDG_RUNTIME_DIR}/.cwd; $PROMPT_COMMAND"

# Change to saved working dir
[[ -f "${XDG_RUNTIME_DIR}/.cwd" ]] && [[ $PWD == ~ ]] && cd "$(< ${XDG_RUNTIME_DIR}/.cwd)"

# Make zsh use the bash PROMPT_COMMAND variable
prmptcmd() { eval "$PROMPT_COMMAND" }
add-zsh-hook precmd prmptcmd

# wal support
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

stty -ixon

# FZF
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude ".pyenv" --exclude "Maildir" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude ".pyenv" --exclude "Maildir" . "$1"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
