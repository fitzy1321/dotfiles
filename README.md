# Fitzypop's Dotfiles and config files

My various config files, fonts, icons, and other things I need across systems.

## Branches

You must switch branch for your respective OS.

`main` is for Linux and MacOS, mainly Pop!_OS/Ubuntu/macOS. Anything with apt or homebrew.

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
stow .
```

## Troubleshooting

### Alacritty

You might need to make a symlink to your fish install like this:

```sh
ln -s <current_fish_locaation> /usr/local/bin/fish
```
