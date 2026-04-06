#!/usr/bin/env dash

if [ -z "$1" ]; then
  git add -N .
else
  git add -N "$1"
fi
