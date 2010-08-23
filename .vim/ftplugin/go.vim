setlocal omnifunc=gocomplete#Complete
set equalprg=gofmt

function! ReformatGo()
    let save_cursor = getpos(".")
    1,$!gofmt
    call setpos('.', save_cursor)
endfunction

" au BufWrite *.go silent call ReformatGo()
