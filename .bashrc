
function git_current_branch() {
    echo $(git branch --show-current)
}

# cd auto move
shopt -s autocd

# Git Aliases
alias g="git"
alias ga="git add"
alias gaa="g add -A"
alias gb="g branch"
alias gba="g branch -a"
alias gbd="g branch -d"
alias gbl="g branch -l"
alias gco="g checkout"
alias gcb="g checkout -b"
alias gcm="g commit -m"
alias gcam="g commit -a -m"
alias gd="g diff"
alias gds="g diff --staged"
alias gl="g pull"
alias gp="g push"
alias gss="g status -s"
alias gst="g status"
alias gpsu='gp --set-upstream origin "$(git_current_branch)"'
alias gpom="gp --set-upstream origin master"
alias gitclean="git branch | grep -ve ' master$' | xargs git branch -D"


# Client related aliases

# Misc Aliases
alias dotfiles="cd /c/source/dotfiles"
alias ls="ls --color=auto"
alias ll="ls -lah"
alias src="source ~/.bashrc && echo 'Re-sourcing bashrc file'"
alias tree="/c/Windows/System32/tree"

# python3.7 alias
alias python37="/c/Users/joe.fitzgibbons/AppData/Local/Programs/Python/Python37/python.exe"

# pipx shell completion
eval "$(register-python-argcomplete pipx)"

# How to install starship on Windows Git Bash:
# mkdir -p ~/bin/starship && cd ~/bin
# curl -fsSL https://starship.rs/install.sh > ./install.sh
# ./install.sh --bin-dir /c/Users/<username>/bin/starship/ --platform pc-windows-msvc
export PATH=$PATH:"$HOME/bin/starship"
eval "$(starship init bash)"

