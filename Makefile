
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: brewinstall
brewinstall:
	brew bundle install --no-lock --file ${DOTFILES}/Brewfile

.PHONY: brewfile
brewfile:
	brew bundle dump -f --no-lock --file ${DOTFILES}/Brewfile

.PHONY: save-vsc-ext
save-vsc-ext:
	code --list-extensions > ${ROOT_DIR}/vscode.extensions

.PHONY: vsc-ext
vsc-ext:
	cat ${ROOT_DIR}/vscode.extensions | xargs -L 1 echo code --install-extensions
