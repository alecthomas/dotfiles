if exists("b:did_bracesplugin")
  finish
endif

inoremap <silent> <CR> <Esc>:call <SID>InsertClosingCurly()<CR>a<CR>

" Inserts a closing }, ] or ) if outside a comment or string, and pressing
" enter immediately after a {, [ or ( at the end of a line.
function! s:InsertClosingCurly()
  " only replace outside of comments or strings (which map to constant)
  let closingChar = {"{": "}", "(": ")", "[": "]"}
  let elesyn = synIDtrans(synID(line("."), col(".") - 1, 0))
  let lineText = getline(line("."))
  let closing = matchstr(lineText, "[[{(]$")
  let enterAfterBrace = col(".") == len(lineText) && closing != ""
  if enterAfterBrace && elesyn != hlID('Comment') && elesyn != hlID('Constant')
    exe "normal o" . closingChar[closing]
    exe "normal kA"
  endif
endfunction

"Surround code with braces
nmap <Leader>{} O{<Esc>ddj>>ddkP
vmap <Leader>{} <Esc>o{<Esc>ddgv>gvdp
