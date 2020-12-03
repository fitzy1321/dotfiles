#!/usr/bin/env bash

# "e" will make script exit if something fails
# "x" will print out every command and its result
# set -x #e

function printsl {
    echo "" # newline
    echo "$1"
    sleep 0.5
}

##### Update system && Instal Packages  #####
printsl "Updating system"
sudo apt update && sudo apt full-upgrade -y

printsl "Installing apt packages"
sudo apt install -y \
    alacritty apt-transport-https build-essential cheese \
    cmake code curl deepin-icon-theme easytag fish gdb gnome-tweaks \
    gir1.2-gtkclutter-1.0 google-chrome-stable gnome-2048 \
    gparted htop libdvd-pkg lollypop make mongodb neofetch neovim \
    preload python3.8 python3-pip python3-dev shellcheck \
    sqlite3 sqlitebrowser symlinks tensorman tree ttf-mscorefonts-installer \
    ubuntu-restricted-extras virtualbox virtualbox-dkms

#####  Installing Flatpaks #####
printsl "Installing flatpaks"
flatpak install flathub \
	postman \
	gitKraken \
    spotify \
	slack \
    zoom

#####  Remove unneed apps  ######
printsl "Apt cleanup"
sudo apt purge --auto-remove -y geary
# clean up
sudo apt autoremove

#####  Python setup  #####
printsl "Installing Python 3.9, Setting up pip and pipenv"

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.9
python3.9 -m pip install -U pip
python3.9 -m pip install -U pipenv

python3.8 -m pip install -U pip
python3.8 -m pip install -U pipenv

#####  Install Brave Browser  #####
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

# #####  Install Dotnet Core 3.1  #####
# printsl "Installing Dotnet Core 3.1"
# wget https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
# sudo dpkg -i packages-microsoft-prod.deb
# sudo apt update
# sudo apt install dotnet-sdk-3.1
# printsl "Installing EF Core CLI Tools" && dotnet tool install --global dotnet-ef
# rm packages-microsoft-prod.dev

#####  Install Node v12.x  #####
printsl "Installing Node JS v14.x"
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install -y nodejs

##### Install "Diff So Fancy" #####
printsl "Installing 'diff-so-fancy' via npm"
sudo npm install -g diff-so-fancy

#####  Install deno  #####
# printsl "Installing Deno via curl"
# curl -fsSL https://deno.land/x/install/install.sh | sh

#####  Install Rust  #####
printsl "Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#####  Install Kite  #####
printsl "Installing kite"
bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)"


#####  Setup  #####
printsl "JFitzy's Pop!_OS setup script!!"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
SHARE="${XDG_DATA_HOME:-$HOME/.local/share}"
DOTFILES="$XDG_CONFIG_HOME/dotfiles"
TMP="$HOME/tmp"
# create tmp folder in case something goes wrong
mkdir "$TMP"


##### Download Git Repos #####
# If repo not in DOTFILES dir, reclone repo to that dir
if [ ! -d "$DOTFILES" ]; then
    printsl "Dotfiles repository not located at $DOTFILES, fixing that now"
    cd "$XDG_CONFIG_HOME" && git clone https://github.com/JFitzy1321/dotfiles.git
fi


SOURCE_DIR="$HOME/Source"
[ ! -d "$SOURCE_DIR" ] && mkdir "$SOURCE_DIR"

#####  Moving Icons to appropriate folder
printsl "Setting up icons and themes folders."

# make icons and theme folders
[ ! -d "$SHARE/icons" ] && mkdir "$SHARE/icons/"
[ ! -d "$SHARE/themes" ] && mkdir "$SHARE/themes"

# extract icons
printsl "Extracting Icon themes to $SHARE/icons"
tar -xf "$DOTFILES/icons/Zafiro-Icons-Blue.tar.gz" -C "$SHARE/icons"

#####  Symlink to Git Config  #####
printsl "Creating symlink for git"
[ ! -d "$XDG_CONFIG_HOME/git" ] && mkdir "$XDG_CONFIG_HOME/git"
ln -s -f "$DOTFILES/config/git/config" "$XDG_CONFIG_HOME/git/."
# ln -s -f "$DOTFILES/config/git/aliasrc" "$XDG_CONFIG_HOME/git/."

#####  Symlink From Scripts folder to bin  #####
printsl "Creating symlink for custom scripts"
[ -d "$HOME/bin" ] && mv "$HOME/bin/" "$HOME/tmp/"
ln -s -f "$DOTFILES/scripts" "$HOME/bin"

#####  Symlink for NeoVim  #####
printsl "Creating symlink for nvim init.vim"
[ ! -d "$XDG_CONFIG_HOME/nvim" ] && mkdir "$XDG_CONFIG_HOME/nvim"
ln -s -f "$DOTFILES/config/nvim/init.vim" "$XDG_CONFIG_HOME/nvim/."

#####  Profile setup  #####
# move .profile and create symlink
printsl "Moving .profile to $TMP"
mv "$HOME/.profile" "$TMP/"

printsl "Creating symlink for .profile"
ln -s -f "$DOTFILES/config/profile" "$HOME/.profile"

#####  Bash Setup  #####
# First, move original to tmp
printsl "Moving $HOME/.bashrc to $TMP"
[ -f "$HOME/.bashrc" ] && mv "$HOME/.bashrc" "$TMP/"

# Second, make symlink to new bashrc location
BASH_PATH="$XDG_CONFIG_HOME/bash"
printsl "Creating symlinks for bashrc to $XDG_CONFIG_HOME/bashrc"
[ ! -d "$BASH_PATH" ] && mkdir "$BASH_PATH"
ln -s -f "$DOTFILES/bash/bashrc" "$BASH_PATH/bashrc"
ln -s -f "$DOTFILES/aliasrc" "$XDG_CONFIG_HOME/aliasrc"

# Third, replace old /etc/bash.bashrc
printsl "Creating a copy of /etc/bash.bashrc in $TMP"
cp /etc/bash.bashrc "$TMP/etc.bash.bashrc"

printsl "Appending /etc/bash.bashrc"
sudo cp -f "$BASH_PATH/etc.bash.bashrc" /etc/bash.bashrc

# ##### Misc #####
# printsl "Symlink for tmux"
# ln -s "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"

##### Fish and Starship Setup  #####
FISH_PATH="$XDG_CONFIG_HOME/fish"

# Move existing file to tmp folder
if [ -f "$FISH_PATH/config.fish" ]; then
    printsl "Moving $FISH_PATH/config.fish to $TMP"
    mv "$FISH_PATH/config.fish" "$TMP"
elif [ ! -d "$FISH_PATH" ]; then
    mkdir "$FISH_PATH"
fi

printsl "Creating symlink for config.fish"
ln -s -f "$DOTFILES/fish/config.fish" "$FISH_PATH/."
ln -s -f "$DOTFILES/fish/fish_variables" "$FISH_PATH/."

printsl "Creating symlinks for fish functions"
[ ! -d "$FISH_PATH/functions" ] && mkdir "$FISH_PATH/functions"
for file in "$DOTFILES/fish/functions"/*
do
    ln -sf "$file" "$FISH_PATH/functions/."
done


printsl "Installing 'Starship' for fish"
curl -fsSL https://starship.rs/install.sh | bash

# Creating symlink for starship.toml
printsl "Creating symlink for starship.toml"
ln -s "$DOTFILES/config/starship.toml" "$XDG_CONFIG_HOME/."

printsl "Setting fish as default shell"
chsh -s "$(which fish)"

#####  Setup Fish for use in other user's terminals
sudo chmod 775 ~/.config/fish
sudo chmod 666 ~/.config/fish/fish_variables

#####  Alacritty  #####
printsl "Creating symlink for alacritty.yaml"
ALACRITTY_PATH="$XDG_CONFIG_HOME/alacritty"
[ ! -d "$ALACRITTY_PATH" ] && mkdir "$ALACRITTY_PATH"
ln -s "$DOTFILES/config/alacritty.yml" "$ALACRITTY_PATH/.alacritty.yml"
