# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

# Remove fish greeting
set -g fish_greeting

if status is-interactive
    # Setup Common Paths
    set -q FISH_PATH; or set -Ux FISH_PATH $HOME/.config/fish

    set -q MYVIMRC; or set -x MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim

    set -q SRC_PATH; or set -x SRC_PATH $HOME/Source

    set -q DOTFILES; or set -x DOTFILES $SRC_PATH/dotfiles

    set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

    # macOS Specific thangs
    if test (uname) = "Darwin"
        alias updatedb="sudo /usr/libexec/locate.updatedb"
        if test -e /opt/homebrew/bin
            fish_add_path /opt/homebrew/bin
        end
        if test -e $HOME/Library/Python/3.9/bin
            fish_add_path $HOME/Library/Python/3.9/bin
        end
    end

    # Aliases
    alias mongo='mongosh'

    # Set Abbreviations
    if test -f $FISH_PATH/abbrevs.fish
        source $FISH_PATH/abbrevs.fish
    end

    # Setup Devtools and paths
    if test -e $FISH_PATH/setup_tools.fish
        source $FISH_PATH/setup_tools.fish
    end
end
