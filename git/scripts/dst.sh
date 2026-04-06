#!/usr/bin/env dash

if [ -z "$1" ]; then
  git diff stash@\{0\}
else
  git diff stash@\{"$1"\}
fi
