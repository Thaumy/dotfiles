#!/usr/bin/env bash

set -e

declare max_commits
max_commits=$(git rev-list --count HEAD)

declare n
if [ -z "$1" ]; then
  n=10
else
  n=$1
fi

if (( n >= max_commits )); then
  git rebase -i --root
else
  git rebase -i "HEAD~$n"
fi
