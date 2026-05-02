#!/usr/bin/env dash

git log \
  --all \
  --graph \
  --oneline \
  --date format:'%y-%m-%d %H:%M' \
  --pretty='%C(yellow)󰜷 %h %C(green)%cd %C(cyan)%an %C(black)%s %C(auto)%(decorate:prefix=[,suffix=],pointer==,tag=🏷 )'
