# Pro-tip: use fish_add_path to edit the PATH variable in this config file
# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# etc: fish_add_path $HOME/.cargo/bin

# for nvm, install with fisher
# `fisher install FabioAntunes/fish-nvm edc/bass`

# Remove fish greeting
set -g fish_greeting

#### Theme
set -Ux theme_nerd_fonts yes

#### Add ENV vars
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx FISH_PATH $XDG_CONFIG_HOME/fish
set -gx MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
set -gx DOTFILES $HOME/.dotfiles
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

#### Linux specific Configs
if test (uname) = "Linux"
end

#### macOS Specific Configs
if test (uname) = "Darwin"
    alias updatedb="sudo /usr/libexec/locate.updatedb"
    if test -e /opt/homebrew/bin; or test -d /opt/homebrew/bin
        fish_add_path /opt/homebrew/bin
    end
    if status is-interactive; and test $TERM_PROGRAM = iTerm.app
        source "$FISH_PATH/iterm2.fish"
    end
end

#### Aliases
type -q exa >/dev/null; and alias ls exa
type -q bat >/dev/null; and alias cat bat

#### Add Paths
if test -d /usr/local/bin; and not contains /usr/local/bin $PATH
    fish_add_path /usr/local/bin
end
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/bin; and fish_add_path $HOME/bin

test -d $HOME/.cargo; and fish_add_path $HOME/.cargo/bin

#### Call other fish config files
if test -e $FISH_PATH/abbrevs.fish; or test -f $FISH_PATH/abbrevs.fish
    source $FISH_PATH/abbrevs.fish
end

#### Setup pyenv
if test -d $HOME/.pyenv
    set -q PYENV_ROOT; or set -gx PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin
    status is-login; and pyenv init --path | source
    status is-interactive; and pyenv init - | source
end


if status is-interactive;
    #### Direnv hook
    type -q direnv; and direnv hook fish | source

    #### Starship hook
    type -q starship; and starship init fish | source
end
