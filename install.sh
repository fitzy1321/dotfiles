#!/usr/bin/env bash

###############################################################################
# JFitzy1321's Linux Install script
# 
# First section:    Install packages via apt and flatpak
#
# Second Section:   Add config files to xdg locations
#
# I'm currently using Pop!_OS and apt to install packages.
# This should be compatiable with any Ubuntu Based Distro.
#
###############################################################################

# "e" will make script exit if something fails
# "x" will print out every command and its result
# set -x #e

function printsl {
    echo "" # newline
    echo "$1"
    sleep 0.5
}

#####  Check if flatpak is installed
if ! flatpak --version; then
    printsl "Flatpak is not installed, installing now"
    apt install flatpak

    printsl "Adding flathub"
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    printsl "Do you want to reboot now? y / n: "

    read answer
    if [ "$answer" == "y" ]; then sudo shutdown -r now ; fi
fi

# Need these to install ppas and setup scripts
sudo apt install apt-transport-https curl software-properties-common

######  Adding ppas  #####

## there's a problem with this ppa
#printsl "Adding deadsnakes ppa"
#sudo add-apt-repository ppa:deadsnakes/ppa -y

printsl "Adding brave ppa"
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

printsl "Adding nodesource ppa"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -

#####  Update system && Install Packages  #####
printsl "Updating System"
sudo apt update && sudo apt upgrade -y

printsl "Installing apt packages"
sudo apt install -y \
    alacritty bridge-utils brave-browser \
    build-essential cheese cmake code curl deepin-icon-theme easytag \
    fish gdb gnome-tweaks gir1.2-gtkclutter-1.0 google-chrome-stable \
    gnome-2048 gparted libdvd-pkg lollypop make mongodb \
    neofetch neovim nodejs preload python3.8 python3.9 python3-pip \
    python3-dev qemu-kvm shellcheck sqlite3 sqlitebrowser symlinks tensorman \
    tree ttf-mscorefonts-installer ubuntu-restricted-extras virt-manager

sudo adduser "$(whoami)" libvirtd

#####  Installing Flatpaks #####
printsl "Installing flatpaks"
flatpak install flathub \
    com.discordapp.Discord \
    com.axosoft.GitKraken \
    com.getpostman.Postman \
    com.slack.Slack \
    com.spotify.Client \
    org.processing.processingide \
    us.zoom.Zoom

#####  Remove unneed apps  ######
printsl "Apt cleanup"
sudo apt purge --auto-remove -y geary

#####  Python setup  #####
printsl "Setting up pip and pipenv"
python3.8 -m pip install -U pip
python3.8 -m pip install -U pipenv
python3.9 -m pip install -U pip
python3.9 -m pip install -U pipenv

##### Install "Diff So Fancy" #####
printsl "Installing 'diff-so-fancy' via npm"
sudo npm install -g diff-so-fancy

#####  Install Rust  #####
printsl "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#####  Install Kite  #####
printsl "Installing kite"
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"

#####  Install Starship Prompt  #####
printsl "Installing 'Starship' for fish"
curl -fsSL https://starship.rs/install.sh | bash

#####  Install Deno  #####
printsl "Installing Deno"
curl -fsSL https://deno.land/x/install/install.sh | sh

###############################################################################
#                                                                             #
#####################################  Section 2  #############################
#                                                                             #
###############################################################################

#####  Setup  #####
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
SHARE="${XDG_DATA_HOME:-$HOME/.local/share}"
DOTFILES="$HOME/.dotfiles"
FISH_PATH="$XDG_CONFIG_HOME/fish"
TMP="$HOME/tmp"

# create tmp folder in case something goes wrong
mkdir "$TMP"

function link {
    ln -sf $1 $2
}

##### Download Git Repos #####
# If repo not in DOTFILES dir, reclone repo to that dir
if [ ! -d "$DOTFILES" ]; then
    printsl "Dotfiles repository not located at $DOTFILES, fixing that now"
    git clone https://github.com/JFitzy1321/dotfiles.git "$DOTFILES"
fi

#####  Moving Icons to appropriate folder
printsl "Setting up icons and themes folders."

# make folders
mkdir -p "$HOME/Source"
mkdir -p "$SHARE/icons/"
mkdir -p "$SHARE/themes"
mkdir "$XDG_CONFIG_HOME/git"
mkdir "$XDG_CONFIG_HOME/nvim"

# extract icons
printsl "Extracting Icon themes to $SHARE/icons"
tar -xf "$DOTFILES/icons/Zafiro-Icons-Blue.tar.gz" -C "$SHARE/icons"

#####  Creating symlinks to various file  #####
printsl "Creating symlink for alacritty.yaml"
link "$DOTFILES/config/alacritty.yml" "$XDG_CONFIG_HOME/."

printsl "Creating symlink for git"
link "$DOTFILES/config/git/config" "$XDG_CONFIG_HOME/git/."

#####  Symlink From Scripts folder to bin  #####
printsl "Creating symlink for custom scripts"
[ -d "$HOME/bin" ] && mv "$HOME/bin/" "$HOME/tmp/"
link "$DOTFILES/scripts" "$HOME/bin"

printsl "Creating symlink for nvim init.vim"
link "$DOTFILES/config/nvim/init.vim" "$XDG_CONFIG_HOME/nvim/."

#####  Profile setup  #####
# move .profile and create symlink
printsl "Moving .profile to $TMP"
mv "$HOME/.profile" "$TMP/"

printsl "Creating symlink for .profile"
link "$DOTFILES/.profile" "$HOME/."

#####  Bash Setup  #####
# First, move original to tmp
printsl "Moving $HOME/.bashrc to $TMP"
[ -f "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$TMP/"

# Second, make symlink to new bashrc location
BASH_PATH="$XDG_CONFIG_HOME/bash"
printsl "Creating symlinks for bashrc to $XDG_CONFIG_HOME/bashrc"
[ ! -d "$BASH_PATH" ] && mkdir "$BASH_PATH"
link "$DOTFILES/config/bash/bashrc" "$BASH_PATH/bashrc"
link "$DOTFILES/config/bash/aliasrc" "$BASH_PATH/aliasrc"

# Third, replace old /etc/bash.bashrc
printsl "Creating a copy of /etc/bash.bashrc in $TMP"
cp /etc/bash.bashrc "$TMP/etc.bash.bashrc"

printsl "Appending /etc/bash.bashrc"
sudo cp -f "$BASH_PATH/etc.bash.bashrc" /etc/bash.bashrc

# Move existing file to tmp folder
if [ -f "$FISH_PATH/config.fish" ]; then
    printsl "Moving $FISH_PATH/config.fish to $TMP"
    mv "$FISH_PATH/config.fish" "$TMP/."
elif [ ! -d "$FISH_PATH" ]; then
    mkdir "$FISH_PATH"
fi

printsl "Creating symlink for config.fish"
link "$DOTFILES/configfish/config.fish" "$FISH_PATH/."
link "$DOTFILES/config/fish/fish_variables" "$FISH_PATH/."

printsl "Creating symlinks for fish functions"
[ ! -d "$FISH_PATH/functions" ] && mkdir "$FISH_PATH/functions"
for file in "$DOTFILES/config/fish/functions"/*
do
    link "$file" "$FISH_PATH/functions/."
done

# Creating symlink for starship.toml
printsl "Creating symlink for starship.toml"
ln -s "$DOTFILES/config/starship.toml" "$XDG_CONFIG_HOME/."

#####  Make fish the default shell  #####
printsl "Setting fish as default shell"
chsh -s "$(which fish)"

#####  Setup Fish for use in other user's terminals
sudo chmod 775 ~/.config/fish
sudo chmod 666 ~/.config/fish/fish_variables

