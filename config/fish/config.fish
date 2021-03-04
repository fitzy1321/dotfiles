#!/usr/bin/env fish

#####  Remove fish greeting  #####
set fish_greeting ""

    #####  Check Dotfiles var exists  #####
    #set -q XDG_CONFIG_HOME; or set -x XDG_CONFIG_HOME "$HOME/.config"
    #set -q DOTFILES; or set -x DOTFILES "$XDG_CONFIG_HOME/dotfiles"

#####  Aliases  #####
alias vim='nvim'
alias ll='ls -lah'

#####  Set Abbreviations  ######
abbr --add dupgrade 'deno upgrade'
abbr --add finstall 'sudo flatpak install flahub'
abbr --add fupdate 'flatpak update'
abbr --add rupdate 'rustup update'
abbr --add update 'sudo apt update && apt list --upgradable'
abbr --add upgrade 'sudo apt upgrade -y'

#####  Git abbreviations  #####
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
    
abbr --add ppath 'echo $PATH'

####    Setup Deno in Path  #####
if test -d $HOME/.local/deno
    fish_add_path $HOME/.local/deno
    set -x DENO_DIR $HOME/.local/deno
else if test -d $HOME/.deno
    fish_add_path $HOME/.deno
    set -x DENO_DIR $HOME/.deno    
end
    
#####   Add cargo to fish path, if it exists    #####
if test -d $HOME/.cargo/bin 
    fish_add_path $HOME/.cargo/bin $fish_user_paths
end
    
#####  Start Starship for Fish  #####
starship init fish | source

