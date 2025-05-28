#!/usr/bin/env bash

if [ $# -eq 1 ] ; then
  echo -n "$(pwd)/$1" | wl-copy
else
  echo -n "$(pwd)" | wl-copy
fi
