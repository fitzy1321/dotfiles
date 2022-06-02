brew-install:
	brew bundle install --no-lock --file ${DOTFILES}/Brewfile

brewfille:
	brew bundle dump --file ${DOTFILES}/Brewfile --no-lock --force
