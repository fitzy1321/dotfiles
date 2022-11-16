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

#### Go / g (go manager) variables
set -gx GOPATH $HOME/go
set -gx GOROOT $HOME/.go
set -gx PATH $GOPATH/bin $PATH
# g-install: do NOT edit, see https://github.com/stefanmaric/g

#### Custom variables
set -q FISH_PATH; or set -gx FISH_PATH $XDG_CONFIG_HOME/fish
set -q MYVIMRC; or set -gx MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
set -q DOTFILES; or set -gx DOTFILES $HOME/.dotfiles
set -q PYTHONSTARTUP; or set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

# macOS Specific thangs
if test (uname -s) = Darwin
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
# not contains /usr/local/bin $PATH; and fish_add_path /usr/local/bin
# not contains $HOME/.local/bin $PATH; and test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
# not contains $HOME/bin; and test -d $HOME/bin; and fish_add_path $HOME/bin
test -d /usr/local/bin; and fish_add_path /usr/local/bin
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

#### Set Abbreviations
# Docker
abbr --add d docker
abbr --add dc docker-compose
abbr --add dcdr 'docker-compose down --remove-orphans'

# Linux Specific things
if test (uname) = Linux
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

abbr --add reset_fish 'source $FISH_PATH/config.fish'

# My virtualenv setup command, easy pyenv integration without a wrapper
if type -q virtualenv
    abbr -a venv 'virtualenv -p (pyenv version-name) .venv'
else
    abbr -e venv
end

# Git abbr's
abbr -a ga 'git add'
abbr -a gaa 'git add -A'

abbr -a gb 'git branch'

abbr -a gcm 'git commit -m'
abbr -a gcam 'git commit -am'

abbr -a gch 'git checkout'
abbr -a gchb 'git checkout -b'
abbr -a gchpoetry 'git checkout master -- poetry.lock'

abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'

abbr -a ggd 'git log --graph --oneline --decorate'

abbr -a gl 'git pull'
abbr -a glv 'git pull && git diff ORIG_HEAD..'

abbr -a gp 'git push'
abbr -a gpu 'git push -u origin'
abbr -a gpum 'git push -u origin main'

abbr -a gst 'git status'
abbr -a gsl 'git status --long'
abbr -a gss 'git status -s'

# Github CLI shortcuts
if type -q gh
    abbr -a gprv 'gh pr view -w'
    abbr -a grv 'gh repo view -w'

else
    abbr -e gprv
    abbr -e grv
end

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
