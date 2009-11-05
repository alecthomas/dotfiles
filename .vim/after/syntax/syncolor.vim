" Vim syntax support file
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last Change:  2001 Sep 12

" This file sets up the default methods for highlighting.
" It is loaded from "synload.vim" and from Vim for ":syntax reset".
" Also used from init_highlight().

if !exists(':SynColor')
  " ":syntax on" works like in Vim 5.7: set colors but keep links
  command -nargs=* SynColor hi <args>
  command -nargs=* SynLink hi link <args>
else
  if syntax_cmd == "enable"
    " ":syntax enable" keeps any existing colors
    command -nargs=* SynColor hi def <args>
    command -nargs=* SynLink hi def link <args>
  elseif syntax_cmd == "reset"
    " ":syntax reset" resets all colors to the default
    command -nargs=* SynColor hi <args>
    command -nargs=* SynLink hi! link <args>
  else
    " User defined syncolor file has already set the colors.
    finish
  endif
endif

if &background == "dark"
    SynColor Comment    cterm=NONE ctermfg=DarkCyan ctermbg=NONE
    SynColor Constant   cterm=NONE ctermfg=White ctermbg=NONE
    SynColor Special    cterm=NONE ctermfg=White ctermbg=NONE
    SynColor Identifier cterm=NONE ctermfg=Gray ctermbg=NONE
    SynColor Statement  cterm=NONE ctermfg=White ctermbg=NONE
    SynColor PreProc    cterm=NONE ctermfg=LightGreen ctermbg=NONE
    SynColor Type       cterm=NONE ctermfg=White ctermbg=NONE
    SynColor Underlined cterm=underline ctermfg=LightBlue
    SynColor Ignore     cterm=NONE ctermfg=Black ctermbg=NONE
    SynColor Error      cterm=NONE ctermfg=White ctermbg=Red
    SynColor Todo       cterm=NONE ctermfg=Black ctermbg=Yellow
    SynColor Search     cterm=bold,underline ctermfg=NONE ctermbg=NONE
    SynColor Folded   cterm=bold ctermfg=cyan ctermbg=NONE

    " Common groups that link to default highlighting.
    " You can specify other highlighting easily.
    SynColor String     cterm=NONE ctermfg=Cyan ctermbg=NONE
    SynLink Character   String
    SynColor Number     cterm=NONE ctermfg=LightYellow ctermbg=NONE
    SynLink Boolean     Constant
    SynLink Float       Number
    SynLink Function    Identifier
    SynLink Conditional Statement
    SynLink Repeat      Statement
    SynLink Label       Statement
    SynLink Operator    Statement
    SynLink Keyword     Statement
    SynLink Exception   Statement
    SynLink Include     PreProc
    SynLink Define      PreProc
    SynLink Macro       PreProc
    SynLink PreCondit   PreProc
    SynLink StorageClass    Type
    SynLink Structure   Type
    SynLink Typedef     Type
    SynLink Tag     Special
    SynLink SpecialChar Special
    SynLink Delimiter   Special
    SynLink SpecialComment  Special
    SynLink Debug       Special

    hi MatchParen cterm=NONE ctermfg=LightGreen ctermbg=NONE
    hi SpecialKey cterm=NONE ctermfg=LightRed ctermbg=NONE
endif

delcommand SynColor
delcommand SynLink
