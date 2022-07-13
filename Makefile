brew-install:
	brew bundle install -- file ${DOTFILES}/Brewfile --no-lock

brewfile:
	brew bundle dump -f --file ${DOTFILES}/Brewfile --no-lock
