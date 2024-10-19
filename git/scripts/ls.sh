#!/usr/bin/env bash

set -e

git log \
  --oneline \
  --date format:'%y-%m-%d %H:%M' \
  --pretty='%C(yellow)🠷 %h %C(green)%cd %C(cyan)%an %C(black)%s %C(auto)%(decorate)' \
  --reverse \
  -n3

git status
