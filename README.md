# Fitzypop's Dotfiles and config files

My various config files, fonts, icons, and other things I need across systems.

![Terminal Image](/assets/terminal.png "My terminal image")

My workflow:

- Terminal: [kitty](https://github.com/kovidgoyal/kitty)
- Prompt: [Starship](https://starship.rs/)
- Shell: [Fish](https://fishshell.com/)
- Editor: [Neovim](https://github.com/neovim/neovim) (and vscode)
- Fonts: [Nerd Fonts](https://www.nerdfonts.com/)
- Dotfiles Management: [GNU Stow](https://www.gnu.org/software/stow/)

## Branches

You must switch branch for your respective OS.

`main` is for Linux and MacOS, mainly Pop!_OS/Ubuntu/macOS. Anything with apt or homebrew.

`windows` is for windows.

## Installation

I use [vscode](https://code.visualstudio.com/docs/setup/mac) as my main editor.

Once you install vscode, run this command to install extensions: `make vsc-ext`

### Clone this repo and run these commands to create my dev workflow

My recommendation is clone this repo into `$HOME/.dotfiles` like this

```git clone <this repo> .dotfiles```

```shell
#linux
apt install -y stow

cd $HOME/.dotfiles
stow .
```

```sh
# macOS Specific installation

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

## Troubleshooting

### Alacritty

You might need to make a symlink to your fish install like this:

```sh
ln -s <current_fish_locaation> /usr/local/bin/fish
```
