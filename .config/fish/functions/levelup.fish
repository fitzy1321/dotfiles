function levelup
    brew update && brew upgrade --greedy && brew cleanup --prune=30 && brew autoremove
    mise self-update -y
    uv self update
    pipx upgrade-all
    cargo install-update --all
end
