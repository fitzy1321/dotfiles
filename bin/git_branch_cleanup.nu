#!/usr/bin/env nu

## https://dev.to/techwatching/clean-up-your-local-git-branches-29kd
git branch -vl | lines | split column " " BranchName Hash Status --collapse-empty | where Status == '[gone]' | each { |it| git branch -D $it.BranchName }
