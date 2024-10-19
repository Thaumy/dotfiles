#!/usr/bin/env bash

if [ -z "$1" ]; then
  git rebase -i HEAD~10
else
  git rebase -i "HEAD~$1"
fi
