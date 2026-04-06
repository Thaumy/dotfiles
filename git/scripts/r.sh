#!/usr/bin/env dash

set -e

max_commits=$(git rev-list --count HEAD)

if [ -z "$1" ]; then
  n=10
else
  n=$1
fi

if [ "$n" -ge "$max_commits" ]; then
  git rebase -ir --root
else
  git rebase -ir "HEAD~$n"
fi
