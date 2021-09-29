#!/usr/bin/env fish

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

status is-interactive; and pyenv init --path | source
pyenv init - | source
