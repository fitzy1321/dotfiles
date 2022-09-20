# Dotfiles for Work Mac

My dev setup and workflow for intel macOS.

![Terminal Image](/assets/terminal.png "My terminal image")

My workflow:

- Terminal: Alacritty
- Prompt: Starship
- Shell: fish
- Editor: Neovim (and vscode)
- Fonts: Nerd Fonts


## Installation

I use [vscode](https://code.visualstudio.com/docs/setup/mac) as my main editor.

### Clone this repo and run these commands to create my dev workflow

My recommendation is clone this repo into `$HOME/.dotfiles` like this

```sh
# install xcode cli tools: need git installed
xcode-select --install

# clone repo to dotfiles dir
git clone git@github.com:joefitzy/dotfiles.git $HOME/.dotfiles

# Move into dotfiles dir
cd $HOME/.dotfiles

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install packages from brewfile
make brewinstall

# install virtualenv
pipx install virtualenv

# use gnu stow to manage symlinks for dotfiles
# must be in $HOME/.dotfiles directory
stow .
```
