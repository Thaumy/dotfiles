" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match buildlogError /\c\<error\>/
syn match buildlogWarn  /\c\<warn\(ing\)\?\>/
syn match buildlogHelp  /\c\<help\>/
syn match buildlogNote  /\c\<note\>/

hi def link buildlogError ErrorMsg
hi def link buildlogWarn WarningMsg
hi def link buildlogHelp LspDiagnosticsHint
hi def link buildlogNote LspDiagnosticsInformation

let b:current_syntax = "buildlog"
