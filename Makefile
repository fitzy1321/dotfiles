
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: brewinstall
brewinstall:
	brew bundle install -- file ${DOTFILES}/Brewfile --no-lock

.PHONY: brewfile
brewfile:
	brew bundle dump -f --file ${DOTFILES}/Brewfile --no-lock

.PHONY: save-vsc-ext
save-vsc-ext:
	code --list-extensions > ${ROOT_DIR}/vscode.extensions

.PHONY: vsc-ext
vsc-ext:
	cat ${ROOT_DIR}/vscode.extensions | xargs -L 1 echo code --install-extensions
