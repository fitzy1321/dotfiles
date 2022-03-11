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
    if test $TERM_PROGRAM = "iTerm.app"
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


#### Alias, mainly rust alternatives
type -q exa; and alias ls exa

if type -q bat
    alias cat bat
else if type -q batcat
    alias cat batcat
end

#### Set Abbreviations
test -f $FISH_PATH/abbrevs.fish; and source $FISH_PATH/abbrevs.fish

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
