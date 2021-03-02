#!/usr/bin/env fish

#####  Remove fish greeting  #####
set fish_greeting ""

if status --is-interactive
   
    ##### Call .profile  #####
    # source ~/.profile;clear; ## removing this for now

    #####  Check Dotfiles var exists  #####
    set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME "$HOME/.config"
    set -q DOTFILES; or set -x DOTFILES "$XDG_CONFIG_HOME/dotfiles"

    #####  Aliases  #####
    alias vim='nvim'
    alias ll='ls -lah'

    #####  Set Abbreviations  ######
    abbr --add autoremove 'sudo apt autoremove'
    abbr --add dupgrade 'deno upgrade'
    abbr --add finstall 'sudo flatpak install flahub'
    abbr --add fupdate 'flatpak update'
    
    abbr --add ga 'git add'
    abbr --add gaa 'git add -A'
    abbr --add gb 'git branch'
    abbr --add gba 'git branch -a'
    abbr --add gbl 'git branch -l'
    abbr --add gbm 'git branch -M'
    abbr --add gcam 'git commit -a -m'
    abbr --add gcb 'git checkout -b'
    abbr --add gcm 'git commit -m'
    abbr --add gco 'git checkout'
    abbr --add gd 'git diff'
    abbr --add gl 'git pull'
    abbr --add gp 'git push'
    abbr --add gpu 'git push -u origin'
    abbr --add gpum 'git push -u origin main'
    abbr --add gsl 'git status --long'
    abbr --add gss 'git status -s'
    abbr --add gst 'git status'
    
    abbr --add mongo-restart 'sudo systemctl restart mongodb.service'
    abbr --add mongo-start 'sudo systemctl start mongodb.service'
    abbr --add mongo-status 'systemctl status mongodb.service'
    abbr --add mongo-stop 'sudo systemctl stop mongodb.service'
    abbr --add ppath 'echo $PATH'
    abbr --add pg_login 'sudo -u joe psql'
    abbr --add pg_createdb 'sudo -u postgres createdb'
    abbr --add rupdate 'rustup update'
    abbr --add update 'sudo apt update && apt list --upgradable'
    abbr --add upgrade 'sudo apt upgrade -y'

    ####    Setup Deno in Path  #####
    if test -d $HOME/.local/deno
        set -U fish_user_paths $HOME/.local/deno $fish_user_paths
        set -x DENO_DIR $HOME/.local/deno
    else if test -d $HOME/.deno
        set -U fish_user_paths $HOME/.deno $fish_user_paths
        set -x DENO_DIR $HOME/.deno
        
    end
    
    #####   Add cargo to fish path, if it exists    #####
    if test -d $HOME/.cargo/bin 
        et -U fish_user_paths $HOME/.cargo/bin $fish_user_paths
    end
    
    #####  Start Starship for Fish  #####
    starship init fish | source
end

