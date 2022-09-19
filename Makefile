brew-install:
	brew bundle install --no-lock --file ${DOTFILES}/Brewfile

.PHONY: brewfile
brewfile:
	brew bundle dump --file ${DOTFILES}/Brewfile --no-lock --force
