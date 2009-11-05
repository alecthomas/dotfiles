set foldmethod=syntax
set foldtext=FoldText()
set fillchars=

map <buffer> - za
map <buffer> <C-f> :call ToggleFold()<CR>

let b:folded = 1

function! ToggleFold()
    if( b:folded == 0 )
        exec "normal! zM"
        let b:folded = 1
    else
        exec "normal! zR"
        let b:folded = 0
    endif
endfunction

function! FoldText()
  return '+' . strpart(getline(v:foldstart), 1) . ' ...'
endfunction
