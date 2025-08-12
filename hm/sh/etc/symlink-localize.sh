#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "do nothing."
  exit
fi

if [ -z "$2" ]; then
  exec fd -d 1 -t l '.*' "$1" -x bash -c 'mv "$(readlink "{}")" "{}"'
else
  exec fd -d "$2" -t l '.*' "$1" -x bash -c 'mv "$(readlink "{}")" "{}"'
fi
