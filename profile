# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022


# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export EDITOR=nvim
export TERMINAL=kitty

#export QT_SCALE_FACTOR=1
#export QT_QPA_PLATFORMTHEME="qt5ct"
#export QT_AUTO_SCREEN_SCALE_FACTOR=1 

# Should fix Skype audio issues
# https://answers.microsoft.com/en-us/skype/forum/skype_linux-skype_callms-skype_audioms/loose-contact-between-skype-and-pulseaudio/aa686d77-8dc4-4f54-aaeb-bee723d2493a
# export PULSE_LATENCY_MSEC=300

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
