# Fitzypop's Dotfiles and config files

Mainly storing dotfiles for my Pop!_OS installation.  
Also contains some Window's config files, fonts, icons,  
and various other files I need across systems.

## Installation

<!-- Run the following command:

`curl -o- https://git.io/J1sXg | sudo -E bash -` -->

Currently reworking all my dotfiles to use gnu stow

clone this repo into this folder `$HOME/.dotfiles`

```git clone <this repo> .dotfiles```

install stow

```shell
#linux
apt install -y stow

#macOS
brew install stow
```

then run these commands

```shell
cd $HOME/.dotfiles
stow home
```
