# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

#### Remove fish greeting
set -g fish_greeting

#### Setup themes
set -Ux theme_nerd_fonts yes

#### XDG variables
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_CACHE_HOME; or set XDG_CACHE_HOME $HOME/.cache

#### Custom variables
set -q FISH_PATH; or set -gx FISH_PATH $XDG_CONFIG_HOME/fish
set -q MYVIMRC; or set -gx MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
set -q DOTFILES; or set -gx DOTFILES $HOME/.dotfiles
set -q PYTHONSTARTUP; or set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

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
    set -q DENO_INSTALL; or set -Ux DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end


#### Alias, mainly rust alternatives
command -v exa >/dev/null; and alias ls exa
command -v bat >/dev/null; and alias cat bat

#### Set Abbreviations
test -f $FISH_PATH/abbrevs.fish; and source $FISH_PATH/abbrevs.fish

#### Other tools
if test -d $HOME/.pyenv
    set -q PYENV_ROOT; or set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    status is-login; and pyenv init --path | source
    status is-interactive; and pyenv init - | source
end

if command -v direnv >/dev/null
    status is-interactive; and direnv hook fish | source
end

if command -v starship >/dev/null
    status is-interactive; and starship init fish | source
end
