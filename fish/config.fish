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
    echo $argv
    if ! set -q $argv[1]
        set -Ux $argv
    end
end

function set_dir_path
    if test -d $argv[1]
        fish_add_path $argv[1]
    end
end

if status is-interactive
    # Setup Common Paths
    set_var CONFIG_PATH $HOME/.config
    set_var FISH_PATH $CONFIG_PATH/fish
    set_var MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
    set_var DOTFILES $HOME/Source/dotfiles
    set_var PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

    set -l PLATFORM (uname -s)


    if test $PLATFORM = "Linux"
        alias mongo='mongosh'
    end

    # macOS Specific thangs
    if test $PLATFORM = "Darwin"
        alias updatedb="sudo /usr/libexec/locate.updatedb"
        if test -e /opt/homebrew/bin
            fish_add_path /opt/homebrew/bin
        end
        if test -e $HOME/Library/Python/3.9/bin
            fish_add_path $HOME/Library/Python/3.9/bin
        end

        set_dir_path /usr/local/bin
    end

    set_dir_path $HOME/.cargo/bin
    set_dir_path $HOME/.local/bin
    set_dir_path $HOME/bin
    set_dir_path $HOME/.deta/bin

    # Set Abbreviations
    src_file $FISH_PATH/abbrevs.fish


    # Deno
    set_var DENO_INSTALL $HOME/.deno
    set_dir_path $DENO_INSTALL/bin

    # Setup pyenv
    set_var PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    pyenv init - | source
    pyenv rehash >/dev/null

    # Starship setup
    starship init fish | source

end
