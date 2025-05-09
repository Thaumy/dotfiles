#!/usr/bin/env bash

if [ $# -eq 1 ] ; then
  echo -n "$(pwd)/$1" | xsel -b
else
  echo -n "$(pwd)" | xsel -b
fi
