function clean_venv
  rm -rf .venv && python -m venv .venv && source .venv/bin/activate.fish && pip install --upgrade pip setuptools wheel && deactivate
end
