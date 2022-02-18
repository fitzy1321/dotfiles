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

    # Linux specific things
    # if test (uname) = "Linux"
    # end

    # macOS Specific thangs
    if test (uname) = "Darwin"
        alias updatedb="sudo /usr/libexec/locate.updatedb"
        if test $TERM_PROGRAM = iTerm.app
            test -e $FISH_PATH/iterm2_shell_integration.fish; and source $FISH_PATH/iterm2_shell_integration.fish
        end

        fish_add_path -m /usr/local/bin
    end

    # Aliases
    # alias ll='ls -lhAF'
    alias mongo='mongosh'

    # Set Abbreviations
    if test -e $FISH_PATH/abbrevs.fish
        or test -f $FISH_PATHS/abbrevs.fish
        source $FISH_PATH/abbrevs.fish
    end

    # Set paths
    if test -e $FISH_PATH/paths.fish
        or test -f $FISH_PATHS/paths.fish
        source $FISH_PATH/paths.fish
    end

    # Set pyenv
    if test -e $FISH_PATH/pyenv_setup.fish
        or test -f $FISH_PATHS/pyenv_setup.fish
        source $FISH_PATH/pyenv_setup.fish
    end

    # Starship Prompt Setup
    starship init fish | source

    # direnv hook
    direnv hook fish | source
end
