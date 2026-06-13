root_dir := justfile_directory()

@_default:
    just --list --unsorted

brewdump:
    brew bundle dump \
        --no-cargo \
        --no-describe \
        --no-flatpak \
        --no-go \
        --no-mas \
        --no-npm \
        --no-uv \
        --no-vscode \
        --force \
        --file {{ root_dir }}/Brewfile

brewinstall:
    brew bundle install --file {{ root_dir }}/Brewfile
