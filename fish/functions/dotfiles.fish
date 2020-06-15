#!/usr/bin/env fish

function dotfiles 
    if not test -d $DOTFILES
        git clone https://github.com/JFitzy1321/dotfiles.git $DOTFILES
    end
    cd $DOTFILES
end

