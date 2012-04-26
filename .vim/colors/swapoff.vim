" VIM custom syntax colouring
" Maintainer: Alec Thomas <alec@swapoff.org>
" Last Change: 2009 Dec 26

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "swapoff"

hi Normal     ctermfg=Gray guifg=#d0d0d0 guibg=black gui=NONE cterm=NONE
hi Comment    guifg=DarkCyan ctermfg=DarkCyan
hi Constant   guifg=White ctermfg=White
hi Special    guifg=White ctermfg=White
hi Identifier guifg=#d0d0d0 ctermfg=Gray
hi Statement  guifg=White ctermfg=White
hi PreProc    guifg=LightGreen ctermfg=LightGreen
hi Type       guifg=White ctermfg=White
hi Underlined gui=underline cterm=underline guifg=LightBlue ctermfg=LightBlue
hi Ignore     guifg=Black ctermfg=Black
hi Error      guifg=White ctermfg=White ctermbg=Red guifg=Red
hi Todo       guifg=Black ctermfg=Black guibg=Yellow
hi Search     gui=bold,underline cterm=bold,underline ctermfg=NONE guifg=NONE guibg=NONE ctermbg=NONE
hi Folded     gui=bold cterm=bold guifg=cyan ctermfg=cyan guibg=NONE ctermbg=NONE
hi String     guifg=Cyan ctermfg=Cyan
hi Number     guifg=LightYellow ctermfg=LightYellow
hi MatchParen guifg=LightGreen ctermfg=LightGreen gui=bold guibg=NONE ctermbg=NONE
hi SpecialKey guifg=LightRed ctermfg=LightRed

hi PyFlakes gui=undercurl guisp=Red ctermfg=LightRed
hi PyFlakesPep8 gui=undercurl guisp=Magenta ctermfg=LightMagenta
hi SpellBad cterm=NONE ctermfg=darkred ctermbg=none

" Links
hi link Character   String
hi link Boolean     Constant
hi link Float       Number
hi link Function    Identifier
hi link Conditional Statement
hi link Repeat      Statement
hi link Label       Statement
hi link Operator    Statement
hi link Keyword     Statement
hi link Exception   Statement
hi link Include     PreProc
hi link Define      PreProc
hi link Macro       PreProc
hi link PreCondit   PreProc
hi link StorageClass    Type
hi link Structure   Type
hi link Typedef     Type
hi link Tag     Special
hi link SpecialChar Special
hi link Delimiter   Special
hi link SpecialComment  Special
hi link Debug       Special

highlight Pmenu ctermbg=238 gui=bold guifg=Grey guibg=#606060
