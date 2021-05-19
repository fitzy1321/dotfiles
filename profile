# Langnostic's .profile
#
# Reminder: This file is not read by bash, if ~/.bash_profile or ~/.bash_login exists.
#
# Setup various shell variables used across environments
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export BASH_PATH="$XDG_CONFIG_HOME/bash"
export SRC_PATH="$HOME/Source"
export DOTFILES="$SRC_PATH/dotfiles"
export LESSHISTFILE=-
export HISTFILE="$XDG_CACHE_HOME/bash_history"

# Remove Python History file with this pythonrc config
export PYTHONSTARTUP="$XDG_CONFIG_HOME/pythonrc"

# Aliases used across shells
# not include 'l' alias, because i want to use fish abbr for it
alias ls="ls --color=auto"
alias ll="ls -lah"
alias wget="wget --hsts-file $XDG_CACHE_HOME/wget_history"
export EDITOR=nvim
export MYVIMRC="$XDG_CONFIG_HOME/nvim/init.vim"

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists (as a file or symlink)
    if [[ -f "$BASH_PATH/bashrc" || -L "$BASH_PATH/bashrc" ]]; then
	. "$BASH_PATH/bashrc"
    fi
fi

# set user's bin in PATH, if it exists
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# set go path, if it exists
[ -d "/usr/local/go" ] && PATH="$PATH:/usr/local/go/bin"

source "$HOME/.cargo/env"
