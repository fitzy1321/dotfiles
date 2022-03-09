if test -d $HOME/Source/vukaheavy
    set -Ux VUKAHEAVY "$HOME/Source/vukaheavy"
    abbr --add vuka "cd $VUKAHEAVY"
    abbr --add ap "cd $VUKAHEAVY/cerebrum"
    abbr --add cp "cd $VUKAHEAVY/customer-portal"
    abbr --add internal "cd $VUKAHEAVY/internal-api-lambda-functions"
    abbr --add external "cd $VUKAHEAVY/sam-api-lambda-functions"
    abbr --add vukalib "cd $VUKAHEAVY/vuka-lib"
    abbr --add vukamodels "cd $VUKAHEAVY/vuka-models"
end

# Updates and Upgrades
abbr --add rupdate "rustup update"

# Linux specific things
if test (uname) = "Linux"
    abbr --add aupdate "sudo apt update && apt list --upgradable"
    abbr --add aupgrade "sudo apt upgrade -y"
    abbr --add fupdate "flatpak update"
    abbr --add flatpak_unused "flatpak uninstall --unused"
end

# Docker
abbr --add d "docker"
abbr --add dc "docker-compose"
abbr --add dcdr "docker-compose down --remove-orphans"


# Misc
abbr --add dotfiles 'cd $DOTFILES'
abbr --add install_vimplugs 'nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"'
if command -v exa >/dev/null
    abbr --add ll 'exa -la --icons --group-directories-first'
else
    abbr --add ll "ls -lhAF"
end
abbr --add ppath 'echo $PATH'
abbr --add py3 "python3.9"
abbr --add reset_fish "source $FISH_PATH/config.fish"
abbr --add rust_book_code "cd $SRC_PATH/rust/book-code && code . && rustup doc --book"

# Git abbr"s
abbr --add ga "git add"
abbr --add gaa "git add -A"
abbr --add gb "git branch"
abbr --add gcam "git commit -a -m"
abbr --add gcb "git checkout -b"
abbr --add gch "git checkout"
abbr --add gcm "git commit -m"
abbr --add gd "git diff"
abbr --add gds "git diff --staged"
abbr --add gl "git pull"
abbr --add glv "git pull && git diff ORIG_HEAD.."
abbr --add gp "git push"
abbr --add gpu "git push -u origin"
abbr --add gpum "git push -u origin main"
abbr --add gsl "git status --long"
abbr --add gss "git status -s"
abbr --add gst "git status"
