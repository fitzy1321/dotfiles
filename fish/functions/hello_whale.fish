#!/usr/bin/env fish

function hello_whale	
    if docker --version 2> /dev/null
        docker run -it danielkraic/asciiquarium
    else
	echo 'Docker is not installed'
    end
end

