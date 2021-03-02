# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Setting XDG variables for my user
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Aliases used across shells
# not include 'l' alias, because i want to use fish abbr for it
alias ls='ls --color=auto'
alias wget="wget --hsts-file $XDG_CACHE_HOME/wget_history"
alias vim='nvim'

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists (as a file or symlink)
    if [[ -f "$XDG_CONFIG_HOME/bash.bashrc" || -L "$XDG_CONFIG_HOME/bash.bashrc" ]]; then
	. "$XDG_CONFIG_HOME/bash.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

