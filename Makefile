ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: brewinstall
brewinstall:
	brew bundle install --no-lock --file ${ROOT_DIR}/Brewfile

.PHONY: brewfile
brewfile:
	brew bundle dump --file ${ROOT_DIR}/Brewfile --no-lock --force
