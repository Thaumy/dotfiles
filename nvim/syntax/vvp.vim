" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match prompt_l1      /^┌╴\zs.*/
syn match prompt_l1_head /^┌╴/   contained containedin=prompt_l1 nextgroup=prompt_l1_tail
syn match prompt_l1_tail /.*/    contained containedin=prompt_l1 skipwhite
syn match prompt_l2      /^└╴\zs.*/
syn match prompt_l2_head /^└╴/   contained containedin=prompt_l2 nextgroup=command
syn match command        /.*/    contained containedin=prompt_l2 skipwhite
syn match output         /^[^┌└].*$/

hi def link output Comment
hi def link prompt_l1_tail Directory
hi def link command String

let b:current_syntax = "vvp"
