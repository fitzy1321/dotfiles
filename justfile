default: brewfile

root_dir := justfile_directory()

brewfile:
	brew bundle dump -f --no-lock --file {{root_dir}}/Brewfile

brewinstall:
	brew bundle install --no-lock --file {{root_dir}}/Brewfile

save-vsc-ext:
	code --list-extensions > {{root_dir}}/vscode.extensions

vsc-ext:
	cat {{root_dir}}/vscode.extensions | xargs -L 1 echo code --install-extensions
