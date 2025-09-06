# Fitypop's Fish Config

# DO NOT MANUALLY EDIT $PATH IN THIS FILE!!!!
# use `fish_add_path` instead: fish_add_path $HOME/.cargo/bin

set -g fish_greeting
set -Ux theme_nerd_fonts yes
set -gx PYTHONDONTWRITEBYTECODE 1 # prevent .pyc files

# XDG variables
set -q XDG_CONFIG_HOME; or set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_CACHE_HOME; or set -gx XDG_CACHE_HOME $HOME/.cache

# disable .lesshst
set -Ux LESSHISTFILE /dev/null

# disable node repl history
set -Ux NODE_REPL_HISTORY ""

# Langs and tools setup
# Rust / Cargo
test -d $HOME/.cargo; and fish_add_path $HOME/.cargo/bin

# Deno setup
if ! set -q DENO_INSTALL and test -d $HOME/.deno
    set -gx DENO_INSTALL $HOME/.deno
    fish_add_path $DENO_INSTALL/bin
end

set -x GOPATH $HOME/go
fish_add_path $GOPATH/bin

if status is-interactive
    # Custom variables
    # set -q EDITOR; or set -gx EDITOR (which nvim)
    set -q FISH_PATH; or set -gx FISH_PATH $XDG_CONFIG_HOME/fish
    set -q DOTFILES; or set -gx DOTFILES $HOME/.dotfiles
    set -q _OS; or set -l _OS (uname -s)

    # Path Setup
    test -d $HOME/.local/bin; and fish_add_path $HOME/.local/bin
    test -d $HOME/bin; and fish_add_path $HOME/bin
    test -d /usr/local/bin; and fish_add_path /usr/local/bin

    # macOS custom settings
    if test $_OS = Darwin
        alias updatedb="sudo /usr/libexec/locate.updatedb"
        # homebrew setup
        test -e /opt/homebrew/bin; or test -d /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin
    end

    # Linux custom dettings
    if test $_OS = Linux
        abbr -a update 'sudo apt update && apt list --upgradable'
        abbr -a upgrade 'sudo apt upgrade -y'
        abbr -a fupdate 'flatpak update'
        abbr -a flatpak_unused 'flatpak uninstall --unused'
    end

    # Kitty custom settings
    if test $TERM = xterm-kitty
        alias ssh="kitten ssh"
    end

    # Docker
    abbr -a d docker
    abbr -a dc 'docker compose'
    abbr -a dcb 'docker compose build'
    abbr -a dcd 'docker compose down'
    abbr -a dcdr 'docker compose down --remove-orphans'
    abbr -a dcu 'docker compose up'
    abbr -a dcud 'docker compose up -d'
    abbr -a d_clean_images "docker rmi (docker images -a --filter=dangling=true -q)"
    abbr -a d_clean_ps "docker rm (docker ps --filter=status=exited --filter=status=created -q)"

    # Git abbr's
    abbr -a ga 'git add'
    abbr -a gaa 'git add -A'

    abbr -a gb 'git branch -l'
    abbr -a gbr 'git branch -r'
    abbr -a gbv 'git branch -vl'

    abbr -a gcb 'git checkout -b'
    abbr -a gch 'git checkout'
    abbr -a gchm 'git checkout main'
    abbr -a gch- 'git checkout -'
    abbr -a gchpoetry 'git checkout master -- poetry.lock'

    abbr -a gcl 'git clean -fdx'

    abbr -a gcm 'git commit -m'
    abbr -a gcam 'git commit -a -m'

    abbr -a gd 'git diff'
    abbr -a gds 'git diff --staged'

    # git diffs without lock files
    set _git_ignore_list "':!/*.lock' ':!/*package-lock.json' ':!/*pnpm-lock.yaml' ':!/*go.sum'"
    abbr -a gdnl git diff -- $_git_ignore_list
    abbr -a gdsnl git diff --staged -- $_git_ignore_list

    abbr -a gfu 'git fetch upstream'

    abbr -a ggd 'git log --graph --oneline --decorate'

    abbr -a gl 'git pull'
    abbr -a glv 'git pull && git diff ORIG_HEAD..'

    abbr -a gp 'git push'
    abbr -a gpu 'git push -u origin HEAD'
    abbr -a gpum 'git push -u origin main'

    abbr -a gs 'git status -s'
    abbr -a gst 'git status'
    abbr -a gsl 'git status --long'

    abbr -a gwc 'git whatchanged -p --abbrev-commit --pretty=medium'

    # Github CLI shortcuts
    if type -q gh
        abbr -a gprv 'gh pr view -w'
        abbr -a grv 'gh repo view -w'
    else
        abbr -e gprv
        abbr -e grv
    end

    # Custom Abbreviations, Aliases, and other shell setup
    type -q bpytop; and abbr -a btop bpytop

    abbr -a cdf 'cd $DOTFILES'
    abbr -a codf 'code $DOTFILES'
    abbr -a cargo-up 'cargo install-update -a'
    abbr -a dev 'cd $HOME/dev/'

    if type -q eza
        abbr -a ls 'eza --icons --group-directories-first'
        abbr -a la 'eza -aG --icons --group-directories-first'
        abbr -a ll 'eza -al --icons --group-directories-first'
        abbr -a lt 'eza -alTL=2 --icons --group-directories-first'
    else if type -q lsd
        abbr -a ls lsd
        abbr -a la 'lsd -lah'
        abbr -a ll 'lsd -lA --group-directories-first'
        abbr -a lt 'lsd -lA --group-directories-first --tree --depth 2'
        abbr -a lta 'lsd -la --group-directories-first --tree'
    else
        abbr -a ll 'ls -lhAF'
    end

    type -q lazydocker; and abbr -a lzd lazydocker
    type -q lazygit; and abbr -a lzg lazygit

    abbr -a refish 'source $FISH_PATH/config.fish'

    type -q supabase; and abbr -a supa supabase

    alias vim='vim -i NONE' # disable viminfo collection

    if type -q zoxide
        zoxide init fish | source
        alias cd z
    end

    type -q starship; and starship init fish | source

    ## ! Do not use asdf and mise together or you're gonna have a bad time 🙅
    ## un/comment the line you want to use below.

    ## asdf ~ dev env
    # test -d $HOME/.asdf; and source $HOME/.asdf/asdf.fish

    ## mise ~ dev env
    type -q mise; and mise activate fish | source
    # ! end warning

    # pnpm (needs to come after dev env setup)
    type -q pnpm; and abbr -a pnpx 'pnpm dlx '
    # pnpm
    set -gx PNPM_HOME /Users/fitzy/Library/pnpm
    if not string match -q -- $PNPM_HOME $PATH
        set -gx PATH "$PNPM_HOME" $PATH
    end
    # pnpm end
end # is-interactive
