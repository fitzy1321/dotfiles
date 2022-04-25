# Fitzypop's Dotfiles and config files

My various config files, fonts, icons, and other things I need across systems.

## Branches

You must switch branch for your respective OS.

`main` is for Linux systems, mainly Pop!_OS/Ubuntu/ anything with apt.

`mac` is for macOS systems, currently working to make it compatiable with m1 macs too.

and

`windows` is for windows.

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
