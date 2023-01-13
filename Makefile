
ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: brewinstall
brewinstall:
	brew bundle install --no-lock --file ${ROOT_DIR}/Brewfile

.PHONY: brewfile
brewfile:
	brew bundle dump -f --no-lock --file ${ROOT_DIR}/Brewfile

.PHONY: save-vsc-ext
save-vsc-ext:
	code --list-extensions > ${ROOT_DIR}/vscode.extensions

.PHONY: vsc-ext
vsc-ext:
	cat ${ROOT_DIR}/vscode.extensions | xargs -L 1 echo code --install-extensions
