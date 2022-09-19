# Dotfiles for Work Mac

This repo is specifically for a macOS system.

## "Installation"

### Install and run these commands to create my dev workflow

Install xcode tools: `xcode-select --install`

Install homebrew: `/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

Install pacakges from Brewfile: `make brew-install`

Install virtualenv `pipx install virtualenv`

Once everything is installed run `stow .`
