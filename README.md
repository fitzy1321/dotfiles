# Fitzy's Dotfiles and config files

My various config files, fonts, icons, and other things I need across systems.

![Terminal Image](/assets/terminal.png "My terminal image")

My setup and tools:

- Terminal: [Kitty](https://github.com/kovidgoyal/kitty), previously [Alacritty](https://github.com/alacritty/alacritty)
- Prompt: [Starship](https://starship.rs/)
- Shell: [Fish](https://fishshell.com/)
- Text Editors: [VS Code](https://code.visualstudio.com/) and [Neovim](https://github.com/neovim/neovim)
- Fonts: [Nerd Fonts](https://www.nerdfonts.com/) (FiraCode and Hack)
- Dotfiles Management: [GNU Stow](https://www.gnu.org/software/stow/)

## Branches

You must switch branch for your respective OS.

`main` is for Linux and MacOS, mainly Pop!_OS/Ubuntu/macOS. Anything with apt or homebrew.

`windows` is for windows.

## Installation

Clone this repo and run these commands to create my dev workflow. My recommendation is clone this repo into `$HOME/.dotfiles` like this

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
git clone git@github.com:fitzy1321/dotfiles.git $HOME/.dotfiles

# Move into dotfiles dir
cd $HOME/.dotfiles

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install packages from brewfile
brew update && brew bundle install --no-lock --file {{root_dir}}/Brewfile

# use gnu stow to manage symlinks for dotfiles
# must be in $HOME/.dotfiles directory
stow .

# change shell to fish
# For mac, add fish path to `/etc/shells` file.
chsh -s $(which fish)

# install uv for python. make sure you have python and pip first

# for macos
curl -LsSf https://astral.sh/uv/install.sh | sh
# or
pipx install uv
```

## ASDF

Let's try out asdf

Do not activate / use while `mise` is active in your shell.
I'm not sure what exactly would happen, but I imagine having 2 shell package managers active would cause all sorts of problems.

Just comment out one or the other lines in `<repo>/.config/fish/config.fish`

<https://asdf-vm.com/guide/getting-started.html/>

```sh
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

# add to fish/config.fish
source ~/.asdf/asdf.fish
# close file

# fish shell completions
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions

# add nodejs plugin
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# install a version
asdf install nodejs latest
```

## Mise

Do not activate / use while `asdf` is active in your shell.
I'm not sure what exactly would happen, but I imagine having 2 shell package managers active would cause all sorts of problems.

Just comment out one or the other lines in `<repo>/.config/fish/config.fish`

<https://mise.jdx.dev/getting-started.html/>

```sh
curl https://mise.run | sh

mise activate fish | source

mise use --global node

## need `usage` to use shell completions
mise use -g usage
# or
cargo install usage-cli
# or
brew install usage
```

```fish
# add this to shell config file
type -q mise; and mise activate fish | source
```

## Troubleshooting

### Alacritty

You might need to make a symlink to your fish install like this:

```sh
ln -s <current_fish_locaation> /usr/local/bin/fish
```
