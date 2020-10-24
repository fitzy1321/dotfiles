# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Set Editor
# Check if nvim is installed by calling --version
# 2> /dev/null will redirect stderr to the null device
# if [ "$(nvim --version 2> /dev/null)" ]; then
#    EDITOR="nvim"
# elif [ "$(vim --version 2> /dev/null)" ]; then
#    EDITOR="vim"
# else
#    EDITOR="nano"
# fi
export EDITOR="nvim"

# Set Browser
export BROWSER="firefox"

# Setting XDG variables for my user
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Aliases used across shells
# not include 'l' alias, because i want to use fish abbr for it
alias ls='ls --color=auto'
alias wget="wget --hsts-file $XDG_CACHE_HOME/wget_history"
alias vim='neovim'

# Setup zsh to point to .config
# if [ "$(zsh --version 2> /dev/null)" ]; then
#    export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
#    [ ! -d "$ZDOTDIR" ] && mkdir "$ZDOTDIR"
# fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists (as a file or symlink)
    if [[ -f "$XDG_CONFIG_HOME/bash/bashrc" || -L "$XDG_CONFIG_HOME/bash/bashrc" ]]; then
	. "$XDG_CONFIG_HOME/bash/bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# set PATH so it includes user's private bin if it exists
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# set rust/cargo in path if cargo directory exists
[ -d "$HOME/.cargo/bin" ] && PATH="$HOME/.cargo/bin:$PATH"

# set deno path if exists
if [ -d "$HOME/.local/deno" ]; then
    PATH="$HOME/.local/deno/bin:$PATH"
    export DENO_DIR="$HOME/.local/deno"
elif [ -d "$HOME/.deno" ]; then
    PATH="$HOME/.deno/bin:$PATH"
    export DENO_DIR="$HOME/.deno"
fi

export PATH
