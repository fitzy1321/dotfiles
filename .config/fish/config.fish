# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# use `fish_add_path` instead: fish_add_path $HOME/.cargo/bin

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
    # if status is-interactive;
    #     and test "$TERM_PROGRAM" = "iTerm.app"
    #     source "$FISH_PATH/iterm2.fish"
    # end
end

#### Add Paths
test -d /usr/local/bin; and fish_add_path /usr/local/bin
test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
test -d $HOME/bin; and fish_add_path $HOME/bin

#### Rust / Cargo
test -d $HOME/.cargo; and fish_add_path $HOME/.cargo/bin

#### Deno setup
if test -d $HOME/.deno
    set -q DENO_INSTALL; or set -gx DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end

#### Aliases
# type -q exa >/dev/null; and alias ls exa

#### Set Abbreviations
if test -d $HOME/dev/vukaheavy
    set -Ux VUKAHEAVY $HOME/dev/vukaheavy
    abbr -a vuka 'cd $VUKAHEAVY'

    abbr -a cerebrum 'cd $VUKAHEAVY/cerebrum'
    abbr -a compass 'cd $VUKAHEAVY/engine-compass'
    abbr -a customerportal 'cd $VUKAHEAVY/customer-portal'
    abbr -a exporteg 'cd $VUKAHEAVY/engine-data-export'
    abbr -a external 'cd $VUKAHEAVY/sam-api-lambda-functions'
    abbr -a internal 'cd $VUKAHEAVY/internal-api-lambda-functions'
    abbr -a monitoring 'cd $VUKAHEAVY/engine-monitoring'
    abbr -a spytego 'cd $VUKAHEAVY/asm-viz'
    abbr -a vukalib 'cd $VUKAHEAVY/vuka-lib'
    abbr -a vukamodels 'cd $VUKAHEAVY/vuka-models'
end

# Docker
abbr -a d 'docker'
abbr -a dc 'docker-compose'
abbr -a dcdr 'docker-compose down --remove-orphans'
abbr -a docker_clean_images "docker rmi (docker images -a --filter=dangling=true -q)"
abbr -a docker_clean_ps "docker rm (docker ps --filter=status=exited --filter=status=created -q)"

# Misc
abbr -a dotfiles 'cd $DOTFILES'
abbr -a install_vimplugs 'nvim -es -u init.vim -i NONE -c "PlugInstall" -c 'qa''
if type -q exa >/dev/null
    abbr -a ls 'exa'
    abbr -a ll 'exa -la --icons --group-directories-first'
    abbr -a lt 'exa -la --icons --group-directories-first --tree --level=2'
else
    abbr -a ll 'ls -lhAF'
end

abbr -a pre 'prevd' # shorthand for previous directory
abbr -a rfish 'source $FISH_PATH/config.fish'

# My virtualenv setup command, easy pyenv integration without a wrapper
type -q virtualenv; and abbr -a nvenv 'virtualenv -p (pyenv version-name) .venv'; or abbr -e nvenv

# Git abbr's
abbr -a ga 'git add'
abbr -a gaa 'git add -A'

abbr -a gb 'git branch'

abbr -a gcm 'git commit -m'
abbr -a gcam 'git commit -am'

abbr -a gch 'git checkout'
abbr -a gchb 'git checkout -b'
abbr -a gchpoetry 'git checkout master -- poetry.lock'

abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'

# git diffs without lock files
set _g_git_ignore_list "':!*Cargo.lock' ':!*package-lock.json' ':!*poetry.lock' ':!*yarn.lock'"
abbr -a gdnl git diff -- {$_g_git_ignore_list}
abbr -a gdsnl git diff --staged -- {$_g_git_ignore_list}

abbr -a ggd 'git log --graph --oneline --decorate'

abbr -a gl 'git pull'
abbr -a glv 'git pull && git diff ORIG_HEAD..'

abbr -a gp 'git push'
abbr -a gpu 'git push -u origin'
abbr -a gpum 'git push -u origin main'

abbr -a gst 'git status'
abbr -a gsl 'git status --long'
abbr -a gss 'git status -s'

# Github CLI shortcuts
if type -q gh
    abbr -a gprv 'gh pr view -w'
    abbr -a grv 'gh repo view -w'

else
    abbr -e gprv
    abbr -e grv
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
