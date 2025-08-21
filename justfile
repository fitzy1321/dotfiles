root_dir := justfile_directory()

@_default:
	just --list --unsorted

brewfile:
	brew bundle dump -f --file {{root_dir}}/Brewfile

brewinstall:
	brew bundle install --no-lock --file {{root_dir}}/Brewfile
