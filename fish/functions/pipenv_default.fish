function pipenv_default
  pipenv --python 3.9
  pipenv install --dev pylint
  pipenv install --dev black --pre
end
