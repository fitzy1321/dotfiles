# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

# Remove fish greeting
set -g fish_greeting

if status is-interactive
    #### Add custom shell variables
    set -Ux XDG_CONFIG_HOME $HOME/.config
    set -Ux FISH_PATH $XDG_CONFIG_HOME/fish
    set -Ux MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
    set -Ux DOTFILES $HOME/Source/dotfiles
    set -Ux PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

    #### Linux specific Configs
    if test (uname) = "Linux"
        alias mongo='mongosh'
    end

    #### macOS Specific Configs
    if test (uname) = "Darwin"
        alias updatedb="sudo /usr/libexec/locate.updatedb"
        if test $TERM_PROGRAM = iTerm.app
            source "$FISH_PATH/iterm2_shell_integration.fish"
        end
    end


    #### Setup paths
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/bin
    
    if test not contains /usr/local/bin $PATH
        fish_add_path /usr/local/bin
    end

    fish_add_path $HOME/.cargo/bin

    #### Call other fish config files
    test -d $FISH_PATH/abbrevs.fish; and source $FISH_PATH/abbrevs.fish

    #### Pyenv setup
    if test -d $HOME/.pyenv
        set -q PYENV_ROOT; or set -Ux PYENV_ROOT $HOME/.pyenv
        fish_add_path $PYENV_ROOT/bin
        pyenv init --path | source
        pyenv init - | source
    end

    #### Direnv Setup
    direnv hook fish | source

    #### Starship Prompt Setup
    starship init fish | source
end
