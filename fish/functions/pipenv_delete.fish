function pipenv_delete
  pipenv --rm
  rm -rf Pipfile Pipfile.lock
end
