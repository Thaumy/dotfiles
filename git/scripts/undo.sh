#!/usr/bin/env bash

if [ "$1" = 'c' ] ; then
  git reset HEAD^
  exit
fi

if [ "$1" = 'm' ] ; then
  git restore .
  exit
fi

if [ "$1" = 'a' ] ; then
  git restore --staged .
  exit
fi

echo 'available options:'
echo 'c: undo commit'
echo 'm: undo modify'
echo 'a: undo add'
