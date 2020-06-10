#!/usr/bin/env bash


# rm all files
git rm -r --cached .
# add all files as per new .gitignore
git add .
# now, commit for new .gitignore to apply
git commit -m "resetting gitignore cache"