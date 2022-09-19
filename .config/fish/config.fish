# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# use `fish_add_path` instead: fish_add_path $HOME/.cargo/bin

# for nvm, install with fisher
# `fisher install FabioAntunes/fish-nvm edc/bass`

# Remove fish greeting
set -g fish_greeting

#### Theme
set -Ux theme_nerd_fonts yes

#### XDG variables
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache

#### Custom variables
set -gx EDITOR (which nvim)
set -gx FISH_PATH $XDG_CONFIG_HOME/fish
set -gx MYVIMRC $XDG_CONFIG_HOME/nvim/init.vim
set -gx DOTFILES $HOME/.dotfiles
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc

#### Linux specific Configs
if test (uname) = "Linux"
end

#### macOS Specific Configs
if test (uname -s) = "Darwin"
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
test -d /usr/local/bin; and fish_add_path /usr/local/bin
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/bin; and fish_add_path $HOME/bin

#### Rust / Cargo
test -d $HOME/.cargo; and fish_add_path $HOME/.cargo/bin

#### Deno setup
if test -d $HOME/.Deno
    set -q DENO_INSTALL; or set -gx DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end

#### Aliases
# type -q exa >/dev/null; and alias ls exa

#### Set Abbreviations
if test -d $HOME/dev/vukaheavy
    set -Ux VUKAHEAVY $HOME/dev/vukaheavy
    abbr --add vuka 'cd $VUKAHEAVY'

    abbr --add cerebrum 'cd $VUKAHEAVY/cerebrum'
    abbr --add compass 'cd $VUKAHEAVY/engine-compass'
    abbr --add customerportal 'cd $VUKAHEAVY/customer-portal'
    abbr --add exporteg 'cd $VUKAHEAVY/engine-data-export'
    abbr --add external 'cd $VUKAHEAVY/sam-api-lambda-functions'
    abbr --add internal 'cd $VUKAHEAVY/internal-api-lambda-functions'
    abbr --add monitoring 'cd $VUKAHEAVY/engine-monitoring'
    abbr --add spytego 'cd $VUKAHEAVY/asm-viz'
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
    abbr --add ls 'exa'
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
abbr --add gchb 'git checkout -b'
abbr --add gchpoetry 'git checkout master -- poetry.lock'

abbr --add gd 'git diff'
abbr --add gds 'git diff --staged'

abbr --add ggd 'git log --graph --oneline --decorate'

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
