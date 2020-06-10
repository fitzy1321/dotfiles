
function git_current_branch() {
    echo $(git branch --show-current)
}

# cd auto move
shopt -s autocd

# Git Aliases
alias gaa="git add -A"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gbl="git branch -l"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gcm="git commit -m"
alias gcam=" git commit -a -m"
alias gl="git pull"
alias gp="git push"
alias gss="git status -s"
alias gst="git status"
alias gpsu='git push --set-upstream origin "$(git_current_branch)"'
alias gpsuom="git push --set-upstream origin master"

# Misc Aliases
alias dotfiles="cd ~/.local/dotfiles"
alias ls="ls --color=auto"
alias l="ls -lah"
alias src="source ~/.bashrc && echo 'Re-sourcing bashrc file'"
