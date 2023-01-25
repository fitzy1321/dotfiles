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

    rm -rf .venv && virtualenv -p (pyenv version-name) .venv && source .venv/bin/activate.fish && ip install --upgrade flake8 flake8-bugbear black isort pep8-naming pytest && deactivate
    return 0
end
