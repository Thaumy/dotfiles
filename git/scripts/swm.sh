#!/usr/bin/env dash

if git show-ref --quiet --heads main; then
  git switch main
else
  git switch master
fi
