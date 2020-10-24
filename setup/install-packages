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

#####  Install Dotnet Core 3.1  #####
printsl "Installing Dotnet Core 3.1"
wget https://packages.microsoft.com/config/ubuntu/19.10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
sudo apt install dotnet-sdk-3.1
printsl "Installing EF Core CLI Tools" && dotnet tool install --global dotnet-ef
rm packages-microsoft-prod.dev

#####  Install Node v12.x  #####
printsl "Installing Node JS v12.x"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
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
