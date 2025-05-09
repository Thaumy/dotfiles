#!/usr/bin/env bash

if [ "$1" = '-c' ]; then
  declare dir
  dir=$(mktemp -d -p /dev/shm/)
  echo -n "$dir" | xsel -b
else
  declare dir
  dir=$(mktemp -d -p /dev/shm/)
  echo "$dir"
fi
