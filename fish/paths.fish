#!/usr/bin/env fish

if test -d $HOME/.cargo
    fish_add_path $HOME/.cargo/bin
end

if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
end

if test -d $HOME/.deta
    fish_add_path $HOME/.deta/bin/
end

if set -q $DENO_INSTALL
    set -x DENO_INSTALL $HOME/.deno
end

if test -d $DENO_INSTALL/bin
    fish_add_path $DENO_INSTALL/bin
end
