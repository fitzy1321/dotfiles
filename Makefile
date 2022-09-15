.PHONY: brewinstall
brewinstall:
	brew bundle install -- file ${DOTFILES}/Brewfile --no-lock

.PHONY: brewfile
brewfile:
	brew bundle dump -f --file ${DOTFILES}/Brewfile --no-lock
