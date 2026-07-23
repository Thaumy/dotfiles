#!/usr/bin/env dash

if [ $# -eq 1 ]; then
  case "$1" in
  /*)
    echo -n "$1" | wl-copy
    ;;
  *)
    echo -n "$(pwd)/$1" | wl-copy
    ;;
  esac
else
  echo -n "$(pwd)" | wl-copy
fi
