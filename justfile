root_dir := justfile_directory()

@_default:
    just --list --unsorted

brewdump:
    brew bundle dump \
        --no-vscode \
        --no-go \
        --no-cargo \
        --no-uv \
        --no-flatpak \
        --no-describe \
        --force \
        --file {{ root_dir }}/Brewfile

brewinstall:
    brew bundle install --file {{ root_dir }}/Brewfile
