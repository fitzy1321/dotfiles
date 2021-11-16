#!/usr/bin/env fish

# Rust / Cargo
if test -d $HOME/.cargo
  fish_add_path $HOME/.cargo/bin
end

# Local Bin
if test -d $HOME/.local/bin
  fish_add_path $HOME/.local/bin
end

# Deta tool
if test -d $HOME/.deta
  fish_add_path $HOME/.deta/bin
end

# Deno
set -q DENO_INSTALL; or set -Ux $HOME/.deno
if test -d $DENO_INSTALL
  fish_add_path $DENO_INSTALL/bin
end

# Setup pyenv
set -Ux PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT
  fish_add_path $PYENV_ROOT/bin
  status is-interactive; and pyenv init --path | source
  pyenv init - | source
end

# Starship setup
status is-interactive; and starship init fish | source
