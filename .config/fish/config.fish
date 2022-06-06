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
    if status is-interactive;
        and test "$TERM_PROGRAM" = "iTerm.app"
        source "$FISH_PATH/iterm2.fish"
    end
end

#### Add Paths
if test -d /usr/local/bin; and not contains /usr/local/bin $PATH
    fish_add_path /usr/local/bin
end
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/bin; and fish_add_path $HOME/bin

test -d $HOME/.cargo; and fish_add_path $HOME/.cargo/bin

#### Aliases
type -q exa >/dev/null; and alias ls exa
type -q bat >/dev/null; and alias cat bat

#### Set Abbreviations
if test -d $HOME/Source/vukaheavy
    set -Ux VUKAHEAVY $HOME/Source/vukaheavy
    abbr --add vuka 'cd $VUKAHEAVY'
    abbr --add cerebrum 'cd $VUKAHEAVY/cerebrum'
    abbr --add customerportal 'cd $VUKAHEAVY/customer-portal'
    abbr --add internal 'cd $VUKAHEAVY/internal-api-lambda-functions'
    abbr --add external 'cd $VUKAHEAVY/sam-api-lambda-functions'
    abbr --add vukalib 'cd $VUKAHEAVY/vuka-lib'
    abbr --add vukamodels 'cd $VUKAHEAVY/vuka-models'
end

# Updates and Upgrades
abbr --add rupdate 'rustup update'

# Docker
abbr --add d 'docker'
abbr --add dc 'docker-compose'
abbr --add dcdr 'docker-compose down --remove-orphans'
abbr --add docker_clean_images "docker rmi (docker images -a --filter=dangling=true -q)"
abbr --add docker_clean_ps "docker rm (docker ps --filter=status=exited --filter=status=created -q)"

# Misc
abbr --add dotfiles 'cd $DOTFILES'
abbr --add install_vimplugs 'nvim -es -u init.vim -i NONE -c "PlugInstall" -c 'qa''
if type -q exa >/dev/null
    abbr --add ll 'exa -la --icons --group-directories-first'
    abbr --add lt 'exa -la --icons --group-directories-first --tree --level=2'
else
    abbr --add ll 'ls -lhAF'
end
abbr --add ppath 'echo $PATH'
abbr --add reset_fish 'source $FISH_PATH/config.fish'

# Git abbr's
abbr --add ga 'git add'
abbr --add gaa 'git add -A'

abbr --add gb 'git branch'

abbr --add gcm 'git commit -m'
abbr --add gcam 'git commit -am'

abbr --add gch 'git checkout'
abbr --add gcb 'git checkout -b'
abbr --add gcpoetry 'git checkout -- poetry.lock'

abbr --add gd 'git diff'
abbr --add gds 'git diff --staged'

abbr --add gl 'git pull'
abbr --add glv 'git pull && git diff ORIG_HEAD..'

abbr --add gp 'git push'
abbr --add gpu 'git push -u origin'
abbr --add gpum 'git push -u origin main'

abbr --add gst 'git status'
abbr --add gsl 'git status --long'
abbr --add gss 'git status -s'


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
