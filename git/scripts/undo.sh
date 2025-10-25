#!/usr/bin/env bash

if [ "$1" = 'c' ]; then
  git reset HEAD^
  exit
fi

if [ "$1" = 'm' ]; then
  if [ -z "$2" ]; then
    git restore .
  else
    git restore "$2"
  fi
  exit
fi

if [ "$1" = 'a' ]; then
  if [ -z "$2" ]; then
    git restore --staged .
  else
    git restore --staged "$2"
  fi
  exit
fi

if [ "$1" = 'n' ]; then
  if [ -z "$2" ]; then
    git clean -df
  else
    rr "$2"
  fi
  exit
fi

if [ "$1" = 'w' ]; then
  git clean -df
  git restore .
  exit
fi

echo 'available options:'
echo 'c: undo commit'
echo 'm [path]: undo modify'
echo 'a [path]: undo add'
echo 'n [path]: undo new files'
echo 'w: undo any writing (equal to m+n)'
