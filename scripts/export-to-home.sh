#!/usr/bin/env bash

DOTFILES="$(pwd)"

# Get top level directory of this repo
# aka, if this Script is executed in "Scripts", move up one dir
if [[ "$DOTFILES" = *"Scripts"* ]]; then
  DOTFILES="$(cd $DOTFILES/.. && pwd)"
fi

# Move shell files
cp $DOTFILES/.profile $HOME/ && source $HOME/.profile
cp $DOTFILES/.alias $HOME/.config/
[ -z "${ZDOTDIR}" ] && echo "ZSH Path not set. Skipping zsh export" || cp $DOTFILES/.zshrc $ZDOTDIR/

# Move zsh themes to custom folder (if exists)
[ -z "${ZSH}" ] && cp *.zsh-theme $ZSH/custom/themes

# Move scripts to bin
[ ! -d $HOME/bin ] && mkdir $HOME/bin
cp $DOTFILES/Scripts/*.sh $HOME/bin/
cp touchx $HOME/bin/
