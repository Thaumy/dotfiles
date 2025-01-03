#!/usr/bin/env bash

if [ -z "$1" ]; then
  git add .
else
  git add "$1"
fi
