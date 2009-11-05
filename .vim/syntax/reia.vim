" Vim syntax file
" Language:     Reia	
" Maintainer:	Jared Kuolt <me@superjared.com>
" Last Change:	2008-11-08
" Filenames:	*.re
" Version:      0.1	

" Based on python.vim found at http://www.vim.org/scripts/script.php?script_id=790

"
" Keywords
syn keyword reiaStatement	break continue del
syn keyword reiaStatement	exec return
syn keyword reiaStatement	pass raise
syn keyword reiaStatement	global assert
syn keyword reiaStatement	lambda yield
syn keyword reiaStatement	with
syn keyword reiaStatement	def class module nextgroup=reiaFunction skipwhite
syn match   reiaFunction	"[a-zA-Z_][a-zA-Z0-9_]*" display contained
syn keyword reiaRepeat	        for while
syn keyword reiaConditional	if elseif else unless
syn keyword reiaImport	        import from as
syn keyword reiaException	try except finally
syn keyword reiaOperator	and in is not or

" Class variables 
syn match   reiaClassvar	"@" display nextgroup=reiaFunction skipwhite

" Regular Expressions
syn match   reiaRegex           "\/.*\/" display

" Comments
syn match   reiaComment	"#.*$" display contains=reiaTodo,@Spell
syn match   reiaRun		"\%^#!.*$"
syn match   reiaCoding	"\%^.*\(\n.*\)\?#.*coding[:=]\s*[0-9A-Za-z-_.]\+.*$"
syn keyword reiaTodo		TODO FIXME XXX contained

" Errors
syn match reiaError		"\<\d\+\D\+\>" display
syn match reiaError		"[$?]" display
syn match reiaError		"[&|]\{2,}" display
syn match reiaError		"[=]\{3,}" display

" Strings
syn region reiaString		start=+[bB]\='+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=reiaEscape,reiaEscapeError,@Spell
syn region reiaString		start=+[bB]\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=reiaEscape,reiaEscapeError,@Spell
syn region reiaString		start=+[bB]\="""+ end=+"""+ keepend contains=reiaEscape,reiaEscapeError,reiaDocTest2,reiaSpaceError,@Spell
syn region reiaString		start=+[bB]\='''+ end=+'''+ keepend contains=reiaEscape,reiaEscapeError,reiaDocTest,reiaSpaceError,@Spell

syn match  reiaEscape		+\\[abfnrtv'"\\]+ display contained
syn match  reiaEscape		"\\\o\o\=\o\=" display contained
syn match  reiaEscapeError	"\\\o\{,2}[89]" display contained
syn match  reiaEscape		"\\x\x\{2}" display contained
syn match  reiaEscapeError	"\\x\x\=\X" display contained
syn match  reiaEscape		"\\$"

" Unicode strings
syn region reiaUniString	start=+[uU]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=reiaEscape,reiaUniEscape,reiaEscapeError,reiaUniEscapeError,@Spell
syn region reiaUniString	start=+[uU]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=reiaEscape,reiaUniEscape,reiaEscapeError,reiaUniEscapeError,@Spell
syn region reiaUniString	start=+[uU]"""+ end=+"""+ keepend contains=reiaEscape,reiaUniEscape,reiaEscapeError,reiaUniEscapeError,reiaDocTest2,reiaSpaceError,@Spell
syn region reiaUniString	start=+[uU]'''+ end=+'''+ keepend contains=reiaEscape,reiaUniEscape,reiaEscapeError,reiaUniEscapeError,reiaDocTest,reiaSpaceError,@Spell

syn match  reiaUniEscape	"\\u\x\{4}" display contained
syn match  reiaUniEscapeError	"\\u\x\{,3}\X" display contained
syn match  reiaUniEscape	"\\U\x\{8}" display contained
syn match  reiaUniEscapeError	"\\U\x\{,7}\X" display contained
syn match  reiaUniEscape	"\\N{[A-Z ]\+}" display contained
syn match  reiaUniEscapeError	"\\N{[^A-Z ]\+}" display contained

" Raw strings
syn region reiaRawString	start=+[rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=reiaRawEscape,@Spell
syn region reiaRawString	start=+[rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=reiaRawEscape,@Spell
syn region reiaRawString	start=+[rR]"""+ end=+"""+ keepend contains=reiaDocTest2,reiaSpaceError,@Spell
syn region reiaRawString	start=+[rR]'''+ end=+'''+ keepend contains=reiaDocTest,reiaSpaceError,@Spell

syn match reiaRawEscape	+\\['"]+ display transparent contained

" Unicode raw strings
syn region reiaUniRawString	start=+[uU][rR]'+ skip=+\\\\\|\\'\|\\$+ excludenl end=+'+ end=+$+ keepend contains=reiaRawEscape,reiaUniRawEscape,reiaUniRawEscapeError,@Spell
syn region reiaUniRawString	start=+[uU][rR]"+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end=+$+ keepend contains=reiaRawEscape,reiaUniRawEscape,reiaUniRawEscapeError,@Spell
syn region reiaUniRawString	start=+[uU][rR]"""+ end=+"""+ keepend contains=reiaUniRawEscape,reiaUniRawEscapeError,reiaDocTest2,reiaSpaceError,@Spell
syn region reiaUniRawString	start=+[uU][rR]'''+ end=+'''+ keepend contains=reiaUniRawEscape,reiaUniRawEscapeError,reiaDocTest,reiaSpaceError,@Spell

syn match  reiaUniRawEscape		"\([^\\]\(\\\\\)*\)\@<=\\u\x\{4}" display contained
syn match  reiaUniRawEscapeError	"\([^\\]\(\\\\\)*\)\@<=\\u\x\{,3}\X" display contained

" Numbers (ints, longs, floats, complex)
syn match   reiaHexError	"\<0[xX]\x*[g-zG-Z]\x*[lL]\=\>" display

syn match   reiaHexNumber	"\<0[xX]\x\+[lL]\=\>" display
syn match   reiaOctNumber "\<0[oO]\o\+[lL]\=\>" display
syn match   reiaBinNumber "\<0[bB][01]\+[lL]\=\>" display

syn match   reiaNumber	"\<\d\+[lLjJ]\=\>" display

syn match   reiaFloat		"\.\d\+\([eE][+-]\=\d\+\)\=[jJ]\=\>" display
syn match   reiaFloat		"\<\d\+[eE][+-]\=\d\+[jJ]\=\>" display
syn match   reiaFloat		"\<\d\+\.\d*\([eE][+-]\=\d\+\)\=[jJ]\=" display

syn match   reiaOctError	"\<0[oO]\=\o*[8-9]\d*[lL]\=\>" display
syn match   reiaBinError	"\<0[bB][01]*[2-9]\d*[lL]\=\>" display

if version >= 508 || !exists("did_reia_syn_inits")
  if version <= 508
    let did_reia_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink reiaStatement	Statement
  HiLink reiaImport		Statement
  HiLink reiaFunction		Function
  HiLink reiaConditional	Conditional
  HiLink reiaRepeat		Repeat
  HiLink reiaException	Exception
  HiLink reiaOperator		Operator

  HiLink reiaDecorator	Define

  HiLink reiaComment		Comment
  HiLink reiaCoding		Special
  HiLink reiaRun		Special
  HiLink reiaTodo		Todo

  HiLink reiaError		Error
  HiLink reiaIndentError	Error
  HiLink reiaSpaceError	Error

  HiLink reiaString		String
  HiLink reiaUniString	String
  HiLink reiaRawString	String
  HiLink reiaUniRawString	String

  HiLink reiaEscape			Special
  HiLink reiaEscapeError		Error
  HiLink reiaUniEscape		Special
  HiLink reiaUniEscapeError		Error
  HiLink reiaUniRawEscape		Special
  HiLink reiaUniRawEscapeError	Error

  HiLink reiaStrFormatting	Special
  HiLink reiaStrFormat    	Special
  HiLink reiaStrTemplate	    Special

  HiLink reiaDocTest		Special
  HiLink reiaDocTest2		Special

  HiLink reiaNumber		Number
  HiLink reiaHexNumber	Number
  HiLink reiaOctNumber	Number
  HiLink reiaBinNumber	Number
  HiLink reiaFloat		Float
  HiLink reiaOctError	    Error
  HiLink reiaHexError		Error
  HiLink reiaBinError		Error

  HiLink reiaBuiltinObj	Structure
  HiLink reiaBuiltinFunc	Function

  HiLink reiaExClass	Structure

  HiLink reiaRegex      Special

  delcommand HiLink
endif

let b:current_syntax = "reia"
