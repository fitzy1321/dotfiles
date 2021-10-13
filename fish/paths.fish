# add local bin to path
if test -d $HOME/.local/bin
    fish_add_path $HOME/.local/bin
end

# add cargo to path
if test -d $HOME/.cargo
    fish_add_path $HOME/.cargo/bin
end

if test -d $HOME/bin
    fish_add_path $HOME/bin
end
