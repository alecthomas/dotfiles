"
" Fold multi-line Python comments into one line.
"
" Also maps the "-" key to toggle expansion and <C-f> to toggle all folding.
"
set foldmethod=syntax
set foldtext=FoldText()
set fillchars=

map <buffer> - za
map <buffer> <C-f> :call ToggleFold()<CR>

let b:folded = 1

function! ToggleFold()
  if b:folded == 0
    exec "normal! zM"
    let b:folded = 1
  else
    exec "normal! zR"
    let b:folded = 0
  endif
endfunction

function! s:Strip(string)
  return substitute(a:string, '^[[:space:][:return:][:cntrl:]]\+\|[[:space:][:return:][:cntrl:]]\+$', '', '')
endfunction

" Extract the first line of a multi-line comment to use as the fold snippet
function! FoldText()
  let l:snippet = getline(v:foldstart)
  if len(s:Strip(l:snippet)) == 3
    let l:snippet = strpart(l:snippet, 1) . s:Strip(getline(v:foldstart + 1))
  endif
  return '+' . l:snippet . ' ...'
endfunction
