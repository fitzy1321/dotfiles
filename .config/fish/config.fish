# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

#### Remove fish greeting
set -g fish_greeting

#### Setup themes
set -Ux theme_nerd_fonts yes

#### XDG variables
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache

#### Custom variables
set -gx FISH_PATH $XDG_CONFIG_HOME/fish
set -gx MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
set -gx DOTFILES $HOME/.dotfiles
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

# macOS Specific thangs
if test (uname -s) = "Darwin"
    alias updatedb="sudo /usr/libexec/locate.updatedb"
    if test -e /opt/homebrew/bin; or test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end
    if status is-interactive;
        and test "$TERM_PROGRAM" = "iTerm.app"
        source $FISH_PATH/iterm2.fish
    end
end

#### Setup paths
if not contains /usr/local/bin $PATH
    fish_add_path /usr/local/bin
end
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/bin; and fish_add_path $HOME/bin

# Rust / Cargo
test -d $HOME/.cargo; and fish_add_path $HOME/.cargo/bin

# Deno
if test -d $HOME/.deno
    set -q DENO_INSTALL; or set -gx DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end


#### Aliases
if type -q bat
    alias cat bat
else if type -q batcat
    alias cat batcat
end

#### Set Abbreviations
# Docker
abbr --add d 'docker'
abbr --add dc 'docker-compose'
abbr --add dcdr 'docker-compose down --remove-orphans'

# Linux Specific things
if test (uname) = 'Linux'
    abbr --add update 'sudo apt update && apt list --upgradable'
    abbr --add upgrade 'sudo apt upgrade -y'
    abbr --add fupdate 'flatpak update'
    abbr --add flatpak_unused 'flatpak uninstall --unused'
end

# Misc
abbr --add dotfiles 'cd $DOTFILES'
abbr --add install_vimplugs 'nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"'

if type -q exa
    abbr --add ls 'exa --icons --group-directories-first'
    abbr --add la 'exa -a --icons --group-directories-first'
    abbr --add ll 'exa -la --icons --group-directories-first'
    abbr --add lt 'exa -la --icons --group-directories-first --tree --level=2'
else
    abbr --add ll 'ls -lhAF'
end

abbr --add ppath 'echo $PATH'
abbr --add reset_fish 'source $FISH_PATH/config.fish'

# Git abbr's
abbr --add ga 'git add'
abbr --add gaa 'git add -A'
abbr --add gb 'git branch'
abbr --add gcam 'git commit -a -m'
abbr --add gcb 'git checkout -b'
abbr --add gch 'git checkout'
abbr --add gcm 'git commit -m'
abbr --add gd 'git diff'
abbr --add gds 'git diff --staged'
abbr --add gl 'git pull'
abbr --add glv 'git pull && git diff ORIG_HEAD..'
abbr --add gp 'git push'
abbr --add gpu 'git push -u origin'
abbr --add gpum 'git push -u origin main'
abbr --add gsl 'git status --long'
abbr --add gss 'git status -s'
abbr --add gst 'git status'


#### Other tools
if test -d $HOME/.pyenv
    set -q PYENV_ROOT; or set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    status is-login; and pyenv init --path | source
    status is-interactive; and pyenv init - | source
end

if status is-interactive
    type -q direnv; and direnv hook fish | source

    type -q starship; and starship init fish | source
end
