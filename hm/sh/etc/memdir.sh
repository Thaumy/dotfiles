#!/usr/bin/env dash

if [ "$1" = '-c' ]; then
  dir=$(mktemp -d -p /dev/shm/)
  echo -n "$dir" | wl-copy
else
  dir=$(mktemp -d -p /dev/shm/)
  echo "$dir"
fi
