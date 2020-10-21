#!/usr/bin/env fish

#####  Remove fish greeting  #####
set fish_greeting ""

if status --is-interactive
    ##### Call .profile  #####
    source ~/.profile;clear;

    #####  Check Dotfiles var exists  #####
    set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME "$HOME/.config"
    set -q DOTFILES; or set -x DOTFILES "$XDG_CONFIG_HOME/dotfiles"

    #####  Set Abbreviations  ######
    abbr --add autoremove 'sudo apt autoremove'
#    abbr --add dupgrade 'deno upgrade'
    abbr --add finstall 'sudo flatpak install flahub'
    abbr --add fupdate 'flatpak update'
    
    abbr --add ga 'git add'
    abbr --add gaa 'git add -A'
    abbr --add gb 'git branch'
    abbr --add gba 'git branch -a'
    abbr --add gbl 'git branch -l'
    abbr --add gcam 'git commit -a -m'
    abbr --add gcb 'git checkout -b'
    abbr --add gcm 'git commit -m'
    abbr --add gd 'git diff'
    abbr --add gl 'git pull'
    abbr --add gp 'git push'
    abbr --add gpsu 'git push --set-upstream origin (git branch --show-current)'
    abbr --add gpsum 'git push --set-upstream origin master'
    abbr --add gsl 'git status --long'
    abbr --add gss 'git status -s'
    abbr --add gst 'git status'
    
    abbr --add l 'ls -lah'
    abbr --add mongo-restart 'sudo systemctl restart mongodb.service'
    abbr --add mongo-start 'sudo systemctl start mongodb.service'
    abbr --add mongo-status 'systemctl status mongodb.service'
    abbr --add mongo-stop 'sudo systemctl stop mongodb.service'
    abbr --add ppath 'echo $PATH'
    abbr --add purge 'sudo apt purge --auto-remove -y'
    abbr --add rupdate 'rustup update'
    abbr --add update 'sudo apt update && apt list --upgradable'
    abbr --add upgrade 'sudo apt upgrade -y'

    #####  Start Starship for Fish  #####
    starship init fish | source
end

