#!/usr/bin/env dash

git reflog \
  --oneline \
  --pretty='%C(yellow)󰜷 %h %>(9)%C(green)%gd %C(cyan)%an %<|(80)%C(black)%gs %C(dim green)%s %C(auto)%(decorate:prefix=[,suffix=],pointer==,tag=🏷 )'
