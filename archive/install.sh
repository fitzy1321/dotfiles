#!/usr/bin/env bash

###############################################################################
# Fitzy's Linux Install script
#
# First section:    Install various packages via apt, flatpak,
#                   and install scripts
#
# Second Section:   Create symlinks for dotfiles
#
# I'm currently using Pop!_OS and apt to install packages.
# This should be compatiable with any Ubuntu Based Distro,
# but I will be assuming Pop!_OS default setup.
#
###############################################################################

# "e" will make script exit if something fails
# "x" will print out every command and its result
# set -x #e

#####################
# Setup Environment / Vars
#####################
DEV_DIR=$HOME/Source
CONFIG_DIR="$HOME/.config"
DOTFILES="$HOME/.dotfiles"
TMP="/tmp"
PLATFORM="$(uname -s)"

printsl() {
    echo "" # newline
    echo "$1"
    sleep 0.5
}

popos_install() {
    # Need these to install ppas and setup scripts
    printsl "Installing prerequesites before installing PPAs."
    sudo apt update
    sudo apt install apt-transport-https curl software-properties-common

    # Adding PPAs for fish, git, brave, node, and gh cli
    printsl "Adding Fish PPA for lastest version of fish shell."
    add-apt-repository ppa:fish-shell/release-3

    printsl "Adding Git Core PPA for latest stable upstream of Git."
    add-apt-repository ppa:git-core/ppa

    printsl "Adding brave ppa"
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    printsl "Adding Github Cli PPA"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    # Update system && Install Packages
    printsl "Updating System"
    sudo apt-get update && sudo apt upgrade -y

    printsl "Installing apt packages"
    cat apt.list | xargs sudo apt-get -y install

    # Remove geary, don't like it
    printsl "Apt cleanup"
    sudo apt purge --auto-remove -y geary

    # Enable Firewall
    printsl "Enabling firewall"
    sudo ufw enable

    sudo adduser "$(whoami)" libvirtd

    # Python setup
    printsl "Installing Python build deps, for pyenv."
    sudo apt-get install -y \
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    python3-pip python3-dev python3-tk python3-venv pyenv scrot

    # Pyenv
    printsl "Installing Pyenv."
    curl https://pyenv.run | bash

    # Installing Flatpaks
    printsl "Installing flatpaks"
    flatpak install flathub \
        com.slack.Slack \
        com.axosoft.GitKraken \
        com.spotify.Client \
        net.cozic.joplin_desktop \
        org.kde.haruna \
        us.zoom.Zoom

    # Install Starship Prompt
    printsl "Installing 'Starship' for fish"
    curl -fsSL https://starship.rs/install.sh | bash

    # Install delta via cargo
    printsl "Installing delta"
    $HOME/.cargo/bin/cargo install git-delta

}

macos_install() {
    # Install macos devtools
    printsl "Installing terminal tools"
    xcode-select --install

    # install homebrew
    printsl "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew doctor

    # Fish shell
    printsl "Installing fish shell"
    brew install fish
    sudo echo "$(which fish)" >> /etc/shells

    # Install devtool
    printsl "Install brew tools from BrewFile"
    brew bundle install --no-lock
}

crossplatform_section() {
    printsl "Setting up pip and pipenv"
    python3 -m pip install -U pip pipx ensurepath pyautogui jupyterlab pandas \
        flake8 black pytest pytest-mock coverage pytext-cov pytest-sugar


    printsl "Install Poetry. Installation script will be saved in $HOME/.cache/ directory."
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py >> $HOME/install-poetry.py
    python3 $HOME/.cache/install-poetry.py

    # Install Rust
    printsl "Installing Rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Update locate db
    if [ "$PLATFORM" == "Darwin"]; then
        sudo /usr/libexec/locate.updatedb
    else
        sudo updatedb
    fi

    # Set fish shell
    chsh -s "$(which fish)"
}

main() {
    # Git Clone dotfiles repo, if not already present
    [ ! -d "$DOTFILES" ] && git clone https://github.com/fitzy1321/dotfiles.git "$DOTFILES"
    cd "$DOTFILES"

    if [ "$PLATFORM" == "Linux" ]; then
        popos_install
    else
        macos_install
    fi

    crossplatform_section

    for filename in $(find . -name "install.sh")
    do
        source "$filename"
    done
}
main
