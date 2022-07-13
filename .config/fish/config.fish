# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

#### Remove fish greeting
set -g fish_greeting

#### Setup themes
set -Ux theme_nerd_fonts yes

#### XDG variables
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME $HOME/.cache

#### Custom variables
set -q FISH_PATH; or set -gx FISH_PATH $XDG_CONFIG_HOME/fish
set -q MYVIMRC; or set -gx MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
set -q DOTFILES; or set -gx DOTFILES $HOME/.dotfiles
set -q PYTHONSTARTUP; or set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

# macOS Specific thangs
if test (uname -s) = 'Darwin'
    alias updatedb='sudo /usr/libexec/locate.updatedb'
    # homebrew setup
    test -e /opt/homebrew/bin; or test -d /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin
    # iterm2 setup
    status is-interactive; and test "$TERM_PROGRAM" = "iTerm.app"; and source $FISH_PATH/iterm2.fish
else
    if test -e /usr/bin/fish; and test ! -e /usr/local/bin/fish
        echo 'Need to make a symlink so fish and alacritty can work together.'
        ln -s /usr/bin/fish /usr/local/bin/fish
    end
end

#### Setup paths
not contains /usr/local/bin $PATH; and fish_add_path /usr/local/bin
not contains $HOME/.local/bin $PATH; and test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
not contains $HOME/bin; and test -d $HOME/bin; and fish_add_path $HOME/bin

# Rust / Cargo
test -d $HOME/.cargo; and fish_add_path $HOME/.cargo/bin

# Deno
if test -d $HOME/.deno
    set -q DENO_INSTALL; or set -gx DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end

#### Aliases

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
abbr --add gcam 'git commit -am'
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
