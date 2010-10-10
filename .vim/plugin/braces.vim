inoremap <CR> <C-R>=InsertClosingCurly()<CR>

" Inserts a closing } if outside a comment or string, and pressing enter
" immediately after a { at the end of a line.
function! InsertClosingCurly()
  " only replace outside of comments or strings (which map to constant)
  let elesyn = synIDtrans(synID(line("."), col(".") - 1, 0))
  let lineText = getline(line("."))
  let enterAfterBrace = col(".") - 1 == len(lineText) && match(lineText, "{$") != -1
  if enterAfterBrace && elesyn != hlID('Comment') && elesyn != hlID('Constant')
    " need to add a spare character (x) to position the cursor afterwards
    exe "normal o "
    exe "normal o}"
    exe "normal k$"
  else
    return "\n"
  endif
  return ""
endfunction

"Surround code with braces
nmap <Leader>{} O{<Esc>ddj>>ddkP
vmap <Leader>{} <Esc>o{<Esc>ddgv>gvdp
