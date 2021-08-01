function pipenv_default
  # Creates a new pipenv, updates pip and install pylint and black.
  # I do these steps everytime I make a new pipenv for a repo.

  # check if python flag passed in.
  # If so, we should get a second arg with the python version
  # i.e. '-p 3.9' or '--python 2'.
  argparse p/python -- $argv

  if set -q _flag_python
    pipenv --python $argv[1]
  else
    pipenv --python 3.9
  end
  
  # update pip in new venv
  pipenv run python -m pip install -U pip
  # install pylint and black, my goto linter and formatter
  pipenv install --dev pylint black --pre
end
