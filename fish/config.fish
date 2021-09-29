# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

# Remove fish greeting
set -g fish_greeting

if status is-interactive
    # Setup Common Paths
    set FISH_PATH $XDG_CONFIG_HOME/fish

    if ! set -q MYVIMRC
        set -x MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
    end

    if ! set -q SRC_PATH
        set -x SRC_PATH $HOME/Source
    end

    if ! set -q DOTFILES
        set -x DOTFILES $SRC_PATH/dotfiles
    end

    set --export PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

    # macOS Specific thangs
    if test (uname) = "Darwin"
        alias updatedb="sudo /usr/libexec/locate.updatedb"
    end

    # Aliases
    alias ll='ls -lhAF'
    alias mongo='mongosh'

    # Set Abbreviations
    if test -f $FISH_PATH/abbrevs.fish
        source $FISH_PATH/abbrevs.fish
    end

    if test -d $HOME/.cargo
        fish_add_path $HOME/.cargo/bin
    end

    if test -d $HOME/.local/bin
        fish_add_path $HOME/.local/bin
    end

    if test -d $HOME/.deta
        fish_add_path $HOME/.deta/bin/
    end

    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin

    status is-interactive; and pyenv init --path | source
    pyenv init - | source

    # Starship Prompt Setup
    starship init fish | source
end

