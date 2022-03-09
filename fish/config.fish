# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

# Remove fish greeting
set -g fish_greeting
set -Ux theme_nerd_fonts yes
set -q XDG_CONFIG_HOME; or set -Ux XDG_CONFIG_HOME $HOME/.config

# macOS Specific thangs
if test (uname -s) = "Darwin"
    alias updatedb="sudo /usr/libexec/locate.updatedb"
    if test -e /opt/homebrew/bin; or test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end
    if test $TERM_PROGRAM = "iTerm.app"
        source "$FISH_PATH/iterm2.fish"
    end
end

# Setup Common Paths
set -q FISH_PATH; or set -Ux FISH_PATH $XDG_CONFIG_HOME/fish
set -q MYVIMRC; or set -xU MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
set -q DOTFILES; or set -Ux DOTFILES $HOME/Source/dotfiles
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

# Rust tool aliases
command -v exa >/dev/null; and alias ls exa
command -v bat >/dev/null; and alias cat bat

# set variables and PATH
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
if not contains /usr/local/bin $PATH
    fish_add_path /usr/local/bin
end

# Rust / Cargo
fish_add_path $HOME/.cargo/bin

# Deno
if test -d $HOME/.deno
    set -q DENO_INSTALL; or set -Ux DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end

# Set Abbreviations
test -f $FISH_PATH/abbrevs.fish; and source $FISH_PATH/abbrevs.fish

# Setup pyenv
if test -d $HOME/.pyenv
    set -q PYENV_ROOT; or set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    status is-login; and pyenv init --path | source
    status is-interactive; and pyenv init - | source
end

if command -v direnv >/dev/null
    status is-interactive; and direnv hook fish | source
end

# Starship
if command -v starship >/dev/null
    status is-interactive; and starship init fish | source
end
