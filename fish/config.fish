# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

# Remove fish greeting
set -g fish_greeting

if status is-interactive
    # Setup Common Paths
    set FISH_PATH $HOME/.config/fish

    if ! set -q MYVIMRC
        set -x MYVIMRC $HOME/.config/nvim/init.vim
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
        if test $TERM_PROGRAM = iTerm.app
            test -e $FISH_PATH/iterm2_shell_integration.fish; and source $FISH_PATH/iterm2_shell_integration.fish
        end
    end

    # Aliases
    alias ll='ls -lhAF'
    alias mongo='mongosh'

    # Set Abbreviations
    if test -e $FISH_PATH/abbrevs.fish
        source $FISH_PATH/abbrevs.fish
    end

    # add local bin to path
    if test -d $HOME/.local/bin
        fish_add_path $HOME/.local/bin
    end

    # add cargo to path
    if test -d $HOME/.cargo
        fish_add_path $HOME/.cargo/bin
    end

    # pyenv setup
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin

    status is-interactive; and pyenv init --path | source
    pyenv init - | source

    # Starship Prompt Setup
    starship init fish | source
end

