#!/usr/bin/env dash

if [ -z "$1" ]; then
  git add .
else
  git add "$1"
fi
