" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match qfInvalid /.*/
syn match qfValid /[^:]\+:\d\+:\d\+ .*/
syn match qfPath  /[^:]\+/ contained containedin=qfValid nextgroup=qfSep1
syn match qfSep1  /:/      contained containedin=qfValid nextgroup=qfRowN
syn match qfRowN  /\d\+/   contained containedin=qfValid nextgroup=qfSep2
syn match qfSep2  /:/      contained containedin=qfValid nextgroup=qfColN
syn match qfColN  /\d\+/   contained containedin=qfValid nextgroup=qfMarkE,qfMarkW,qfMsg skipwhite
syn match qfMarkE /\[E\]/  contained containedin=qfMsg skipwhite
syn match qfMarkW /\[W\]/  contained containedin=qfMsg skipwhite
syn match qfMarkI /\[I\]/  contained containedin=qfMsg skipwhite
syn match qfMarkH /\[H\]/  contained containedin=qfMsg skipwhite
syn match qfMsg   /.*/     contained

hi def link qfInvalid Comment
hi def link qfPath Directory
hi def link qfSep1 Delimiter
hi def link qfRowN Number
hi def link qfSep2 Delimiter
hi def link qfColN Number
hi def link qfMarkE ErrorMsg
hi def link qfMarkW WarningMsg
hi def link qfMarkI LspDiagnosticsInformation
hi def link qfMarkH LspDiagnosticsHint

let b:current_syntax = "qf"
