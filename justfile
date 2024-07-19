default: brewfile

root_dir := justfile_directory()

brewfile:
	brew bundle dump -f --no-lock --file {{root_dir}}/Brewfile

brewinstall:
	brew bundle install --no-lock --file {{root_dir}}/Brewfile
