# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export BASH_PATH="$XDG_CONFIG_HOME/bash"
export SRC_PATH="$HOME/Source"
export DOTFILES="$SRC_PATH/dotfiles"
export LESSHISTFILE=-
export HISTFILE="$XDG_CACHE_HOME/bash_history"

# Remove Python History file with this pythonrc config
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"

# Aliases used across shells
# not include 'l' alias, because i want to use fish abbr for it
alias ls="ls --color=auto"
alias wget="wget --hsts-file $XDG_CACHE_HOME/wget_history"
alias vim="nvim"
export EDITOR=vim

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists (as a file or symlink)
    if [[ -f "$BASH_PATH/bashrc" || -L "$BASH_PATH/bashrc" ]]; then
	. "$BASH_PATH/bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

source "$HOME/.cargo/env"
