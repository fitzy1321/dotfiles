function clean_venv --description="Delete current virtualenv and create a new one with virtualenv and pyenv"
    if ! type -q virtualenv
        echo "Please install virtualenv"
        return 1
    end

    if ! type -q pyenv
        echo "please install pyenv"
    end

    if ! test -d .venv
        echo ".venv directory not found!"
        return 1
    end

    rm -rf .venv && virtualenv -p (pyenv version-name) .venv && source .venv/bin/activate.fish && pip install -U pip black isort pytest ruff && deactivate
    return 0
end
