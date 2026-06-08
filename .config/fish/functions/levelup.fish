function levelup
    brew update && brew upgrade
    mise self-update -y --silent
    uv self update
    pipx upgrade-all
    cargo install-update --all

end
