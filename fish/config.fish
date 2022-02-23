# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

# Remove fish greeting
set -g fish_greeting

function src_file
    if test -e $argv[1]
        or test -f $argv[1]
        source $argv[1]
    end
end

function set_var
    if ! set -q $argv[1]
        set -x $argv
    end
end


function set_dir_path
    if test -d $argv[1]
        fish_add_path $argv[1]
    end
end


if status is-interactive
    #### Add custom shell variables
    set_var FISH_PATH $HOME/.config/fish
    set_var MYVIMRC $HOME/.config/nvim/init.vim
    set_var SRC_PATH $HOME/Source
    set_var DOTFILES $SRC_PATH/dotfiles
    set_var PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

    #### Linux specific Configs
    if test (uname) = "Linux"
        alias mongo='mongosh'
    end

    #### macOS Specific Configs
    if test (uname) = "Darwin"
        alias updatedb="sudo /usr/libexec/locate.updatedb"
        if test $TERM_PROGRAM = iTerm.app
            src_file $FISH_PATH/iterm2_shell_integration.fish
        end

        # Need to make sure this is in $PATH for loading and calling components/plugins/tools
        fish_add_path -m /usr/local/bin
    end

    #### Setup paths
    set_dir_path $HOME/.local/bin
    set_dir_path $HOME/.cargo
    set_dir_path $HOME/bin

    #### Call other fish config files
    src_file $FISH_PATH/abbrevs.fish

    #### Pyenv setup
    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init --path | source
    pyenv init - | source
    # pyenv rehash >/dev/null

    #### Direnv Setup
    direnv hook fish | source

    #### Starship Prompt Setup
    starship init fish | source

end
