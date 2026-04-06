#!/usr/bin/env dash

set -e

git log \
  --oneline \
  --date format:'%y-%m-%d %H:%M' \
  --pretty='%C(yellow)🠷 %h %C(green)%cd %C(cyan)%an %C(dim green)%s %C(auto)%(decorate:prefix=[,suffix=],pointer==,tag=🏷 )' \
  --reverse \
  -n3

git status
